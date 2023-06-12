import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:honors_app/modules/get.hornors/provider/get.hornors.provider.dart';
import 'package:provider/provider.dart';
import '../../../../common/values/app.colors.dart';
import '../../../common/widgets/hornors.item.dart';
import '../../../common/widgets/show.score.dart';
import '../../../models/hornors.dart';
import '../../../models/user.dart';
import '../../../service/admob.repo.dart';
import '../../profile/screen/profile.screen.dart';

class GetHornorsScreen extends StatefulWidget {
  const GetHornorsScreen({super.key});

  @override
  State<GetHornorsScreen> createState() => _GetHornorsScreenState();
}

class _GetHornorsScreenState extends State<GetHornorsScreen> {
  GetHornorsProvider provider = GetHornorsProvider();
  BannerAd? bannerAd;
  bool isAdLoad = false;
  @override
  void initState() {
    super.initState();
    provider.init();
    // initBannnerAd();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<GetHornorsProvider>(
      create: ((context) => provider),
      builder: (context, child) {
        return Consumer<GetHornorsProvider>(builder: (context, model, child) {
          return Scaffold(
            backgroundColor: AppColor.secondary,
            appBar: AppBar(
              backgroundColor: AppColor.primary,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text('Được vinh danh'),
            ),
            bottomNavigationBar: isAdLoad
                ? SizedBox(
                    height: bannerAd!.size.height.toDouble(),
                    width: double.infinity,
                    child: AdWidget(ad: bannerAd!),
                  )
                : null,
            body: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  height: height * 0.35,
                  width: double.infinity,
                  color: AppColor.primary,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      model.photoURL != null
                          ? SizedBox(
                              height: 120,
                              width: 120,
                              child: CircleAvatar(
                                radius: 110,
                                backgroundImage:
                                    NetworkImage(model.photoURL ?? ''),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        model.userLogined ?? '',
                        style: const TextStyle(
                            fontSize: 25,
                            color: AppColor.secondary,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        model.emailLogin ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            color: AppColor.secondary,
                            fontWeight: FontWeight.w100),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      model.photoURL != null
                          ? ShowScore(
                              score: model.score,
                              number: model.listHornors!.length,
                            )
                          : Container()
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: _itemHornors(model))
              ],
            ),
          );
        });
      },
    );
  }

  Widget _itemHornors(GetHornorsProvider model) {
    return model.workspaceID != null
        ? PaginateFirestore(
            onEmpty: const Padding(
              padding: EdgeInsets.only(bottom: 500),
              child: Center(
                child: Text('Chưa có vinh danh nào!'),
              ),
            ),
            itemBuilderType: PaginateBuilderType.listView,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            onLoaded: (context) => const CircularProgressIndicator(),
            itemBuilder: (context, documentSnapshots, index) {
              final data = documentSnapshots[index].data() as Map?;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () async {
                    Users u = await model.getUser(data['userSet'] ?? '');
                    onTap(u, model);
                  },
                  child: HonorsItems(
                    isHome: false,
                    isGet: true,
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
                .where("userGet", isEqualTo: model.userLogined)
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

  void onTap(Users u, GetHornorsProvider model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ProfileScreen(
                  user: u,
                )));
  }
}
