import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/common/values/app.text.dart';
import 'package:honors_app/models/core.value.dart';
import 'package:honors_app/modules/bottom/bottom.navigation.dart';
import 'package:honors_app/modules/core.value/provider/corevalue.provider.dart';
import 'package:honors_app/modules/core.value/screen/detail.value.screen.dart';
import 'package:honors_app/modules/core.value/widget/add.core.value.dart';
import 'package:honors_app/service/admob.repo.dart';
import 'package:provider/provider.dart';
import '../widget/score.setting.dart';

class CoreValueScreen extends StatefulWidget {
  const CoreValueScreen(
      {super.key,
      required this.isFirst,
      required this.automaticallyImplyLeading});
  final bool isFirst;
  final bool automaticallyImplyLeading;

  @override
  State<CoreValueScreen> createState() => _CoreValueScreenState();
}

class _CoreValueScreenState extends State<CoreValueScreen> {
  final CoreValueProvider provider = CoreValueProvider();
  RewardedAd? rewardedAd;
  @override
  void initState() {
    super.initState();
    provider.getCoreValue();
    // initRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CoreValueProvider>(
      create: ((context) => provider),
      builder: ((context, child) {
        return Consumer<CoreValueProvider>(
          builder: (context, model, child) {
            return Scaffold(
                backgroundColor: AppColor.secondary,
                appBar: AppBar(
                  backgroundColor: AppColor.primary,
                  automaticallyImplyLeading: widget.automaticallyImplyLeading,
                  centerTitle: true,
                  title: const Text(AppText.titleCoreValue),
                  actions: [
                    IconButton(onPressed: create, icon: const Icon(Icons.add)),
                    IconButton(
                        onPressed: settingScore,
                        icon: const Icon(Icons.settings)),
                  ],
                ),
                body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: model.listCore != null && model.listCore!.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.listCore!.length,
                            itemBuilder: (BuildContext context, int index) {
                              CoreValue coreValue = model.listCore![index];
                              return InkWell(
                                onTap: () {
                                  model.setValueOnTap(
                                      model.listCore![index].title ?? '',
                                      model.listCore![index].content ?? '');
                                  onTap(model.listCore![index], model);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black54,
                                                width: 1))),
                                    child: ListTile(
                                      title: Text(coreValue.title ?? ""),
                                      subtitle: Text(coreValue.content ?? ""),
                                    ),
                                  ),
                                ),
                              );
                            })
                        : model.listCore != null && model.listCore!.isEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 200,
                                    ),
                                    const Text(
                                      'Chưa có giá trị cốt lõi nào!',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    TextButton(
                                        onPressed: create,
                                        child: const Text(
                                          'THÊM NGAY',
                                          style: TextStyle(
                                            fontSize: 22,
                                            color: AppColor.primary,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.primary,
                                  strokeWidth: 2,
                                ),
                              )),
                floatingActionButton: widget.isFirst &&
                        model.listCore != null &&
                        model.listCore!.isNotEmpty
                    ? FloatingActionButton(
                        backgroundColor: AppColor.primary,
                        onPressed: done,
                        child: const Icon(
                          Icons.done,
                          color: AppColor.secondary,
                        ),
                      )
                    : Container());
          },
        );
      }),
    );
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
        }, onAdFailedToLoad: (erro) {
          setState(() {
            rewardedAd = null;
          });
        }));
  }

  void setFullScreenContentCallBack() {
    if (rewardedAd == null) return;
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {},
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
        });
    rewardedAd != null ? showRewardedAd() : null;
  }

  void showRewardedAd() {
    rewardedAd!.show(onUserEarnedReward: (ad, re) {});
  }

  void settingScore() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => ScoreSetting(model: provider));
  }

  void done() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavigation()),
      (Route<dynamic> route) => false,
    );
  }

  void create() {
    provider.clearCtl();
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AddCoreValue(provider: provider));
  }

  void onTap(CoreValue item, CoreValueProvider model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => DetailCoreValue(
                  item: item,
                  model: model,
                )));
  }
}
