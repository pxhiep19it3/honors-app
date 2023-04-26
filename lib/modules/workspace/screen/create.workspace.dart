import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:honors_app/modules/information/screen/policy.screen.dart';
import 'package:honors_app/modules/information/screen/privacy.screen.dart';
import 'package:honors_app/modules/workspace/provider/workspace.provider.dart';
import 'package:honors_app/modules/workspace/screen/add.user.screen.dart';
import 'package:provider/provider.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/values/app.text.dart';
import '../../../common/widgets/basic.button.dart';
import '../../../service/admob.repo.dart';
import '../../auth/screen/logineds.screen.dart';
import '../widget/check.box.dart';
import '../widget/inline.text.button.dart';
import '../widget/select.job.dart';
import '../widget/text.input.dart';

class CreateWorkspaceScreen extends StatefulWidget {
  const CreateWorkspaceScreen({super.key, required this.admin, this.user});
  final String admin;
  final User? user;
  @override
  State<CreateWorkspaceScreen> createState() => _CreateWorkspaceScreenState();
}

class _CreateWorkspaceScreenState extends State<CreateWorkspaceScreen> {
  bool isCheck = false;
  final WorkspaceProvider _workspaceProvider = WorkspaceProvider();
  final _formKey = GlobalKey<FormState>();

  InterstitialAd? interstitialAd;
  @override
  void initState() {
    super.initState();
    initInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<WorkspaceProvider>(
      create: ((context) => _workspaceProvider),
      builder: ((context, child) =>
          Consumer<WorkspaceProvider>(builder: (context, model, child) {
            return Scaffold(
              backgroundColor: AppColor.secondary,
              appBar: AppBar(
                title: const Text(AppText.titleCreateWorkspace),
                centerTitle: true,
                backgroundColor: AppColor.primary,
                automaticallyImplyLeading: false,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginedScreen(
                                  user: widget.user!,
                                )),
                        (Route<dynamic> route) => false,
                      );
                    },
                    icon: const Icon(Icons.arrow_back)),
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
                            height: 10,
                          ),
                          Row(
                            children: [
                              CheckBox(
                                isCheck: isCheck,
                                onpress: setCheck,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Đồng ý',
                                style: TextStyle(
                                    fontSize: 15, color: AppColor.black),
                              ),
                              InlineTextButton(
                                  text: ' Chính sách',
                                  function: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const PolicyScreen()));
                                  }),
                              const Text(
                                ' và ',
                                style: TextStyle(
                                    fontSize: 15, color: AppColor.black),
                              ),
                              InlineTextButton(
                                  text: 'Quyền riêng tư',
                                  function: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const PrivacyScreen()));
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BacsicButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  isCheck) {
                                continute(model, widget.admin);
                              } else {
                                showErro();
                              }
                            },
                            label: AppText.btContinute,
                            width: width * 0.85,
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

  void setCheck() {
    setState(() {
      isCheck = !isCheck;
    });
  }

  void continute(WorkspaceProvider model, String admin) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => AddUserScreen(
                  isFirst: true,
                  admin: admin,
                  provider: model,
                )));
  }

  void showErro() {
    final snackBar = SnackBar(
      content: const Text('Đồng ý Chính sách và Quyền riêng tư!'),
      action: SnackBarAction(
        label: '',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
