import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/common/values/app.text.dart';
import 'package:honors_app/common/widgets/basic.button.dart';
import 'package:honors_app/modules/auth/screen/login.screen.dart';
import 'package:honors_app/modules/workspace/screen/create.workspace.dart';

import '../../../service/admob.repo.dart';
import '../../workspace/screen/group.joined.screen.dart';

class LoginedScreen extends StatefulWidget {
  const LoginedScreen({super.key, required this.user});
  final User user;

  @override
  State<LoginedScreen> createState() => _LoginedScreenState();
}

class _LoginedScreenState extends State<LoginedScreen> {
  InterstitialAd? interstitialAd;
  @override
  void initState() {
    super.initState();
    initInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 150,
            ),
            SizedBox(
              height: 180,
              width: 180,
              child: CircleAvatar(
                radius: 110,
                backgroundImage: NetworkImage(widget.user.photoURL ?? ''),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              widget.user.displayName ?? '',
              style: const TextStyle(
                  fontSize: 25,
                  color: AppColor.secondary,
                  fontWeight: FontWeight.bold),
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
            const Spacer(),
            BacsicButton(
                onPressed: () {
                  create(context, widget.user.email ?? '');
                },
                label: AppText.btCreateNew,
                width: width * 0.85,
                primary: true),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  join(context, widget.user.email ?? '');
                },
                child: const Text(
                  AppText.btJoin,
                  style: TextStyle(
                      color: AppColor.secondary,
                      fontSize: 20,
                      decoration: TextDecoration.underline),
                )),
            TextButton(
                onPressed: () {
                  logout(context);
                },
                child: const Text(
                  'Chọn tài khoản khác',
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontSize: 15,
                  ),
                )),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  void join(BuildContext context, String emailMember) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const GroupJoined()));
  }

  void create(BuildContext context, String admin) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateWorkspaceScreen(
                admin: admin,
              )),
    );
  }

  void logout(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }

  initInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdMobRepo.adUnitIdLogined!,
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
