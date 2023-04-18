import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/common/values/app.icons.dart';
import 'package:honors_app/common/values/app.text.dart';
import 'package:honors_app/common/widgets/basic.button.dart';
import 'package:honors_app/modules/workspace/provider/workspace.provider.dart';
import 'package:honors_app/modules/workspace/screen/sent.email.screen.dart';
import 'package:honors_app/modules/workspace/widget/area.user.dart';
import 'package:provider/provider.dart';

import '../../../service/admob.repo.dart';
import '../../core.value/screen/core.value.screen.dart';
import '../widget/text.input.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({
    super.key,
    required this.isFirst,
    required this.admin,
    required this.provider,
  });
  final bool isFirst;
  final String admin;
  final WorkspaceProvider provider;

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  BannerAd? bannerAd;
  bool isAdLoad = false;
  @override
  void initState() {
    super.initState();
    initBannnerAd();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<WorkspaceProvider>(builder: (context, model, child) {
      return Scaffold(
          backgroundColor: AppColor.secondary,
          appBar: AppBar(
            backgroundColor: AppColor.primary,
            centerTitle: true,
            title: const Text(AppText.titleAddUser),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      TextInput(
                        controller: model.member,
                        width: width,
                        label: 'VD: example@gmail.com',
                      ),
                      InkWell(
                        onTap: model.addMember,
                        child: Image.asset(
                          AppIcon.addMember,
                          width: 50,
                          height: 50,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AreaUser(
                    width: width,
                    users: model.listMember.reversed.toList(),
                    provider: model,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BacsicButton(
                      onPressed: () {
                        model.createWorkspace(widget.admin, widget.provider);
                        model.listMember.isNotEmpty
                            ? sentEmail(context, model)
                            : skip(context);
                      },
                      label: model.listMember.isEmpty
                          ? 'Bỏ qua'
                          : AppText.btSendEmail,
                      width: width,
                      primary: false)
                ],
              ),
            ),
          ),
          bottomNavigationBar: isAdLoad
              ? SizedBox(
                  height: bannerAd!.size.height.toDouble(),
                  width: bannerAd!.size.width.toDouble(),
                  child: AdWidget(ad: bannerAd!),
                )
              : Container());
    });
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

  void sentEmail(BuildContext context, WorkspaceProvider model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => SentEmailScreen(
                  users: model.listMember.reversed.toList(),
                  isFirst: widget.isFirst,
                )));
  }

  void skip(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const CoreValueScreen(
                isFirst: true, automaticallyImplyLeading: false)));
  }
}
