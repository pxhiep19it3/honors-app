import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:honors_app/models/user.dart';
import 'package:honors_app/modules/set.hornors/provider/set.hornors.provider.dart';
import 'package:provider/provider.dart';
import '../../../../common/values/app.colors.dart';
import '../../../common/widgets/hornors.item.dart';
import '../../../models/hornors.dart';
import '../../../service/admob.repo.dart';
import '../../profile/screen/profile.screen.dart';

class SetHornorsScreen extends StatefulWidget {
  const SetHornorsScreen({super.key});

  @override
  State<SetHornorsScreen> createState() => _SetHornorsScreenState();
}

class _SetHornorsScreenState extends State<SetHornorsScreen> {
  SetHornorsProvider provider = SetHornorsProvider();

  BannerAd? bannerAd;
  bool isAdLoad = false;
  @override
  void initState() {
    super.initState();
    provider.init();
    initBannnerAd();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SetHornorsProvider>(
      create: ((context) => provider),
      builder: (context, child) {
        return Consumer<SetHornorsProvider>(builder: (context, model, child) {
          return Scaffold(
              backgroundColor: AppColor.secondary,
              appBar: AppBar(
                backgroundColor: AppColor.primary,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: const Text('Đã vinh danh'),
              ),
              bottomNavigationBar: isAdLoad
                  ? SizedBox(
                      height: bannerAd!.size.height.toDouble(),
                      width: double.infinity,
                      child: AdWidget(ad: bannerAd!),
                    )
                  : null,
              body: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: _itemHornors(model)));
        });
      },
    );
  }

  Widget _itemHornors(SetHornorsProvider model) {
    return model.workspaceID != null
        ? PaginateFirestore(
            itemBuilderType: PaginateBuilderType.listView,
            onLoaded: (context) => const CircularProgressIndicator(),
            onEmpty: const Center(
              child: Text('Chưa có vinh danh nào!'),
            ),
            itemBuilder: (context, documentSnapshots, index) {
              final data = documentSnapshots[index].data() as Map?;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () async {
                    Users u = await model.getUser(data['userGet'] ?? '');
                    onTap(u, model);
                  },
                  child: HonorsItems(
                    isHome: false,
                    hornors: Hornors(
                        time: data!['time'],
                        userGet: data['userGet'],
                        userSet: data['userSet'],
                        score: data['score'],
                        content: data['content'],
                        coreValue: data['coreValue']),
                  ),
                ),
              );
            },
            query: FirebaseFirestore.instance
                .collection('Hornors')
                .where('workspaceID', isEqualTo: model.workspaceID)
                .where("userSet", isEqualTo: model.userLogined)
                .orderBy('time', descending: true),
            isLive: true,
            itemsPerPage: 5,
          )
        : Container();
  }

  initBannnerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
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

  void onTap(Users u, SetHornorsProvider model) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ProfileScreen(
                  user: u,
                )));
  }
}
