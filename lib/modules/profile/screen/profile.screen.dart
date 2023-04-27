import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:honors_app/common/widgets/hornors.item.dart';
import 'package:honors_app/modules/profile/provider/profile.provider.dart';
import 'package:provider/provider.dart';
import '../../../../common/values/app.colors.dart';
import '../../../common/widgets/show.score.dart';
import '../../../models/user.dart';
import '../../../common/widgets/hornors.dart';
import '../../../service/admob.repo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user});
  final Users user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileProvider provider = ProfileProvider();
  final ScrollController _scrollController = ScrollController();
  BannerAd? bannerAd;
  bool isAdLoad = false;

  @override
  void initState() {
    super.initState();
    provider.init(widget.user);
    // initBannnerAd();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        provider.init(widget.user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<ProfileProvider>(
        create: ((context) => provider),
        builder: (context, child) {
          return Consumer<ProfileProvider>(builder: (context, model, child) {
            return Scaffold(
              backgroundColor: AppColor.secondary,
              appBar: AppBar(
                backgroundColor: AppColor.primary,
                centerTitle: true,
                title: Text(widget.user.displayName ?? ''),
                actions: [
                  IconButton(
                      onPressed: () {
                        favorite(widget.user.displayName ?? '', model);
                      },
                      icon: const Icon(Icons.favorite))
                ],
              ),
              body: ListView(
                shrinkWrap: true,
                controller: _scrollController,
                children: [
                  Container(
                    height: height * 0.3,
                    width: double.infinity,
                    color: AppColor.primary,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        widget.user.photoURL != null
                            ? SizedBox(
                                height: 120,
                                width: 120,
                                child: CircleAvatar(
                                  radius: 110,
                                  backgroundImage:
                                      NetworkImage(widget.user.photoURL ?? ''),
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.user.email ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColor.secondary,
                              fontWeight: FontWeight.w100),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ShowScore(
                          number: model.listHornors!.length,
                          score: model.score,
                        ),
                      ],
                    ),
                  ),
                  model.listHornors!.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: model.listHornors!.length,
                          itemBuilder: (BuildContext context, index) => Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: HonorsItems(
                                  hornors: model.listHornors![index],
                                ),
                              ))
                      : Container()
                ],
              ),
              bottomNavigationBar: isAdLoad
                  ? SizedBox(
                      height: bannerAd!.size.height.toDouble(),
                      width: double.infinity,
                      child: AdWidget(ad: bannerAd!),
                    )
                  : null,
            );
          });
        });
  }

  void favorite(String name, ProfileProvider model) {
    model.listCoreValue.isNotEmpty
        ? showDialog<String>(
            context: context,
            builder: (BuildContext context) => Hornors(
                  name: name,
                  coreValue: model.listCoreValue,
                  setScore: model.setScore,
                  setCoreValue: model.setCoreValue,
                  controller: model.contentHornors,
                  createHornors: model.createHornors,
                ))
        : null;
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
}
