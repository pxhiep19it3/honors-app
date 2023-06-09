import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:honors_app/modules/auth/screen/logineds.screen.dart';
import 'package:honors_app/modules/workspace/provider/workspace.provider.dart';
import 'package:honors_app/modules/workspace/screen/other.information.screen.dart';
import 'package:provider/provider.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/values/app.text.dart';
import '../../../common/widgets/basic.button.dart';
import '../../../service/admob.repo.dart';
import '../widget/select.job.dart';
import '../widget/text.input.dart';

class CreateWorkspaceScreen extends StatefulWidget {
  const CreateWorkspaceScreen(
      {super.key, required this.admin, required this.user});
  final String admin;
  final User user;
  @override
  State<CreateWorkspaceScreen> createState() => _CreateWorkspaceScreenState();
}

class _CreateWorkspaceScreenState extends State<CreateWorkspaceScreen> {
  final WorkspaceProvider _workspaceProvider = WorkspaceProvider();
  final _formKey = GlobalKey<FormState>();

  InterstitialAd? interstitialAd;
  @override
  void initState() {
    super.initState();
    // initInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<WorkspaceProvider>(
      create: ((context) => _workspaceProvider),
      builder: ((context, child) =>
          Consumer<WorkspaceProvider>(builder: (context, model, child) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColor.secondary,
              appBar: AppBar(
                title: const Text(AppText.titleCreateWorkspace),
                centerTitle: true,
                backgroundColor: AppColor.primary,
                automaticallyImplyLeading: false,
                leading: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginedScreen(
                                  user: widget.user,
                                )),
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
              ),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            AppText.titleWorkspace,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          TextInput(
                            controller: model.nameWorkspaceCtl,
                            width: width,
                            label: 'Tên doanh nghiệp',
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextInput(
                            controller: model.phoneCtl,
                            width: width,
                            label: 'Số điện thoại',
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextInput(
                            controller: model.addressCtl,
                            width: width,
                            label: 'Địa chỉ',
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          JobDropButton(
                            width: width,
                            provider: model,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          BacsicButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                continute(model, widget.admin);
                              } else {}
                            },
                            label: AppText.btContinute,
                            width: width,
                            primary: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }

  void continute(WorkspaceProvider model, String admin) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => OtherInformationScreen(
                  admin: admin,
                  model: model,
                )));
  }

  initInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdMobRepo.adUnitIdCreateWorkspace!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              interstitialAd = ad;
              setfullScreenContentCallback(ad);
            },
            onAdFailedToLoad: (LoadAdError error) => interstitialAd = null));
  }

  setfullScreenContentCallback(InterstitialAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {});
    interstitialAd != null ? interstitialAd!.show() : null;
  }
}
