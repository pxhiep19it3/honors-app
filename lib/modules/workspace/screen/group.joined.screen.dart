// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:honors_app/models/workspace.dart';
import 'package:honors_app/modules/workspace/provider/workspace.provider.dart';
import 'package:honors_app/service/admob.repo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/values/app.colors.dart';
import '../../bottom/bottom.navigation.dart';
import '../widget/delete.workspace.dart';
import '../widget/out.workspace.dart';

class GroupJoined extends StatefulWidget {
  const GroupJoined({super.key});

  @override
  State<GroupJoined> createState() => _GroupJoinedState();
}

class _GroupJoinedState extends State<GroupJoined> {
  final WorkspaceProvider _provider = WorkspaceProvider();

  BannerAd? bannerAd;
  bool isAdLoad = false;

  @override
  void initState() {
    super.initState();
    _provider.getWorkspace();
    // initBannnerAd();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WorkspaceProvider>(
      create: ((context) => _provider),
      builder: (context, child) =>
          Consumer<WorkspaceProvider>(builder: (context, model, child) {
        return Scaffold(
            backgroundColor: AppColor.secondary,
            appBar: AppBar(
              backgroundColor: AppColor.primary,
              centerTitle: true,
              title: const Text('Nhóm đã tham gia'),
            ),
            body: model.listWorkspace != null && model.listWorkspace!.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.listWorkspace!.length,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        onTap: () {
                          onTap(model, index);
                        },
                        title: Text(
                          model.listWorkspace![index].name ?? '',
                          style: const TextStyle(
                              fontSize: 18, color: AppColor.black),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              trailing(model.listWorkspace![index], model);
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: AppColor.black,
                            )),
                      );
                    },
                  )
                : model.listWorkspace != null && model.listWorkspace!.isEmpty
                    ? const Center(
                        child: Text('Bạn chưa tham gia nhóm nào!'),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primary,
                          strokeWidth: 2,
                        ),
                      ),
            bottomNavigationBar: isAdLoad
                ? SizedBox(
                    height: bannerAd!.size.height.toDouble(),
                    width: bannerAd!.size.width.toDouble(),
                    child: AdWidget(ad: bannerAd!),
                  )
                : null);
      }),
    );
  }

  initBannnerAd() {
    bannerAd = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: AdMobRepo.adUnitIdJoin!,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isAdLoad = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
        }),
        request: const AdRequest());
    bannerAd!.load();
  }

  void onTap(WorkspaceProvider model, int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'nameWorkspace', model.listWorkspace![index].name ?? '');
    await prefs.setString(
        'workspaceID', model.listWorkspace![index].workspaceID ?? '');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavigation()),
      (Route<dynamic> route) => false,
    );
  }

  void trailing(
    Workspace workspace,
    WorkspaceProvider model,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: model.emailLogin == workspace.admin ? 280 : 150,
          color: AppColor.gray,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavigation()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  title: Text(
                    workspace.name ?? '',
                    style: const TextStyle(fontSize: 18, color: AppColor.black),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    await out(workspace, model);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text(
                    'Rời khỏi',
                    style: TextStyle(fontSize: 18, color: AppColor.black),
                  ),
                ),
                model.emailLogin == workspace.admin
                    ? ListTile(
                        onTap: () async {
                          await delete(workspace, model);
                          Navigator.pop(context);
                        },
                        leading: const Icon(Icons.delete),
                        title: const Text(
                          'Xóa nhóm',
                          style: TextStyle(fontSize: 18, color: AppColor.black),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        );
      },
    );
  }

  Future delete(Workspace workspace, WorkspaceProvider model) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DeleteWorkspace(
          workspace: workspace,
          model: model,
          isFirst: true,
          notifyListener: true,
        );
      },
    );
  }

  Future out(Workspace workspace, WorkspaceProvider model) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return OutWorkspace(
          workspace: workspace,
          model: model,
          isAdmin: model.emailLogin == workspace.admin,
        );
      },
    );
  }
}
