// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
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
import '../../../service/admob.repo.dart';
import '../../auth/widget/new.version.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  String? nameWorkspace;
  final HomeProvider provider = HomeProvider();
  BannerAd? bannerAd;
  bool isAdLoad = false;
  String? workspaceID;


  final newVersion = NewVersionPlus(
    androidId: 'vn.doitsolutions.honorsApp',
    iOSId: 'vn.doitsolutions.honorsApp',
  );

  bool test = false;

  @override
  void initState() {
    super.initState();
    // checkNewVersion();
    getData();
    init();
    // initBannnerAd();
  }

  void checkNewVersion() async {
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

  RewardedAd? rewardedAd;

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameWorkspace = prefs.getString('nameWorkspace');
      workspaceID = prefs.getString('workspaceID');
    });
    provider.init(workspaceID!);
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      workspaceID = prefs.getString('workspaceID');
    });
    provider.getData(workspaceID!);
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
                    : Text(nameWorkspace ?? ''),
                actions: [
                  IconButton(
                      onPressed: showSearch,
                      icon: isSearch
                          ? const Icon(Icons.cancel)
                          : const Icon(Icons.search))
                ],
              ),
              drawer: DrawerHome(
                nameWorkspace: nameWorkspace ?? '',
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

  Widget _body(BuildContext context, HomeProvider model) {
    return !isSearch
        ? (model.listHornors != null && model.listHornors!.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 40, right: 15, left: 15),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.listHornors!.length,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8),
                          child: HonorsItems(
                            hornors: model.listHornors![index],
                          ));
                    }),
              )
            : model.listHornors != null && model.listHornors!.isEmpty
                ? const Center(
                    child: Text(
                      'Chưa có vinh danh nào!',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primary,
                      strokeWidth: 2,
                    ),
                  ))
        : SearchItem(
            users: model.listUser,
            model: model,
            workspace: nameWorkspace ?? '',
          );
  }

  showSearch() {
    setState(() {
      isSearch = !isSearch;
    });
    setState(() {
      test = true;
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

  void initRewardedAd() {
    RewardedAd.load(
        adUnitId: AdMobRepo.adUnitIdRewaredAd!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          setState(() {
            rewardedAd = ad;
          });
          setFullScreenContentCallBack();
          rewardedAd!.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {});
        }, onAdFailedToLoad: (erro) {
          setState(() {
            rewardedAd = null;
          });
        }));
    rewardedAd == null ? showRewardedAd() : null;
  }

  void setFullScreenContentCallBack() {
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

  void showRewardedAd() {
    rewardedAd!.show(onUserEarnedReward: (ad, re) {});
  }
}
