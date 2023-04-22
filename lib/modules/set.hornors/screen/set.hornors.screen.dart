import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:honors_app/models/user.dart';
import 'package:honors_app/modules/set.hornors/provider/set.hornors.provider.dart';
import 'package:provider/provider.dart';
import '../../../../common/values/app.colors.dart';
import '../../../common/widgets/hornors.item.dart';
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
    init();
    // initBannnerAd();
  }

  void init() {
    provider.init();
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
              body: model.listHornors != null && model.listHornors!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: model.listHornors!.length,
                          itemBuilder: (BuildContext context, index) => InkWell(
                                onTap: () async {
                                  Users u = await model.getUser(
                                      model.listHornors![index].userGet ?? '');
                                  onTap(u, model);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: HonorsItems(
                                      hornors: model.listHornors![index],
                                      isHome: false,
                                    )),
                              )),
                    )
                  : model.listHornors != null && model.listHornors!.isEmpty
                      ? const Center(
                          child: Text(
                            'Chưa có vinh danh nào!',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ));
        });
      },
    );
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
