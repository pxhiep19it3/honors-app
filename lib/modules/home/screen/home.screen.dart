// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:honors_app/modules/home/provider/home.provider.dart';
import 'package:honors_app/modules/home/screen/hornors.creen.dart';
import 'package:honors_app/modules/home/widget/drawer.dart';
import 'package:honors_app/modules/home/widget/search.item.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/values/app.colors.dart';
import '../../../common/widgets/hornors.item.dart';

import '../../../common/widgets/search.field.dart';
import '../../../models/hornors.dart';
import '../../../service/admob.repo.dart';
import '../../auth/widget/new.version.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  final HomeProvider provider = HomeProvider();
  BannerAd? bannerAd;
  bool isAdLoad = false;
  RewardedAd? rewardedAd;
  String? workspaceName;
  final newVersion = NewVersionPlus(
    androidId: 'vn.doitsolutions.honorsApp',
    iOSId: 'vn.doitsolutions.honorsApp',
  );

  @override
  void initState() {
    super.initState();
    // checkNewVersion();
    init();
    initBannnerAd();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      workspaceName = prefs.getString('nameWorkspace');
    });
    provider.init();
  }

  checkNewVersion() async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return UpdateDialog(
            description: status.releaseNotes!,
            version: status.storeVersion,
            appLink: status.appStoreLink,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: ((context) => provider),
      builder: (context, child) {
        return Consumer<HomeProvider>(builder: (context, model, child) {
          Future.delayed(Duration.zero, () {
            if (model.isAdMob) {
              model.setAdMob();
              initRewardedAd();
            }
          });
          return Scaffold(
              backgroundColor: AppColor.secondary,
              appBar: AppBar(
                backgroundColor: AppColor.primary,
                centerTitle: true,
                title: isSearch
                    ? SearchField(
                        controller: model.searchCTL,
                        label: 'Tìm kiếm',
                        onChange: model.onSearch,
                      )
                    : Text(workspaceName ?? ''),
                actions: [
                  IconButton(
                      onPressed: showSearch,
                      icon: isSearch
                          ? const Icon(Icons.cancel)
                          : const Icon(Icons.search))
                ],
              ),
              drawer: DrawerHome(
                nameWorkspace: workspaceName ?? '',
                emailLogin: model.emailLogin,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  model.listCoreValue.isNotEmpty && model.listUser.isNotEmpty
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HornorsScreen(
                                    coreValue: model.listCoreValue,
                                    setScore: model.setScore,
                                    setCoreValue: model.setCoreValue,
                                    controller: model.contentHornors,
                                    createHornors: model.createHornors,
                                    users: model.listUser,
                                    setUser: model.setUserHornors,
                                  )))
                      : null;
                },
                backgroundColor: AppColor.primary,
                child: const Icon(
                  Icons.favorite,
                ),
              ),
              bottomNavigationBar: isAdLoad
                  ? SizedBox(
                      height: bannerAd!.size.height.toDouble(),
                      width: double.infinity,
                      child: AdWidget(ad: bannerAd!),
                    )
                  : null,
              body: _body(context, model));
        });
      },
    );
  }

  Widget _itemHornors(BuildContext context, HomeProvider model) {
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
                child: HonorsItems(
                  hornors: Hornors(
                      time: data!['time'],
                      userGet: data['userGet'],
                      userSet: data['userSet'],
                      score: data['score'],
                      content: data['content'],
                      coreValue: data['coreValue']),
                ),
              );
            },
            query: FirebaseFirestore.instance
                .collection('Hornors')
                .where('workspaceID', isEqualTo: model.workspaceID)
                .orderBy('time', descending: true),
            isLive: true,
            itemsPerPage: 5,
          )
        : Container();
  }

  Widget _body(BuildContext context, HomeProvider model) {
    return !isSearch
        ? Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 40, right: 15, left: 15),
            child: _itemHornors(context, model))
        : SearchItem(
            users: model.listUser,
            model: model,
            workspace: workspaceName ?? '',
          );
  }

  showSearch() {
    setState(() {
      isSearch = !isSearch;
    });
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

  initRewardedAd() {
    RewardedAd.load(
        adUnitId: AdMobRepo.adUnitIdRewaredAd!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          setState(() {
            rewardedAd = ad;
          });
          setFullScreenContentCallBack();
          rewardedAd != null
              ? rewardedAd!.show(
                  onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {})
              : null;
        }, onAdFailedToLoad: (erro) {
          setState(() {
            rewardedAd = null;
          });
        }));
  }

  setFullScreenContentCallBack() {
    if (rewardedAd == null) return;
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {},
        onAdDismissedFullScreenContent: (ad) {
          setState(() {
            rewardedAd = null;
          });
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          setState(() {
            rewardedAd = null;
          });
          ad.dispose();
        });
  }
}
