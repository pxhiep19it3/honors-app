import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/values/app.colors.dart';
import '../../../service/admob.repo.dart';
import '../../auth/screen/login.screen.dart';
import '../widget/profile.item.screen.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  String? _userLogined = '';
  String? _emailLogin = '';
  String? _photoURL;
  BannerAd? bannerAd;
  bool isAdLoad = false;
  @override
  void initState() {
    super.initState();
    init();
    initBannnerAd();
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userLogined = prefs.getString('userLogined');
      _emailLogin = prefs.getString('emailLogin');
      _photoURL = prefs.getString('photoURL');
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: const Text('Thông tin'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                logout(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: isAdLoad
          ? SizedBox(
              height: bannerAd!.size.height.toDouble(),
              width: double.infinity,
              child: AdWidget(ad: bannerAd!),
            )
          : null,
      body: Column(
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
                _photoURL != null
                    ? SizedBox(
                        height: 120,
                        width: 120,
                        child: CircleAvatar(
                          radius: 110,
                          backgroundImage: NetworkImage(_photoURL!),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _userLogined!,
                  style: const TextStyle(
                      fontSize: 25,
                      color: AppColor.secondary,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  _emailLogin!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      color: AppColor.secondary,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            children: [
              InformationItem(
                emailLogin: _emailLogin ?? '',
              ),
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Text(
                  'Phiên bản: 1.0.0',
                  style: TextStyle(color: AppColor.black),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  initBannnerAd() {
    bannerAd = BannerAd(
        size: AdSize.largeBanner,
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
}
