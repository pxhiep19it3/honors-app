// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/common/values/app.images.dart';
import 'package:honors_app/common/values/app.text.dart';
import 'package:honors_app/common/widgets/basic.button.dart';
import 'package:honors_app/modules/auth/screen/login.screen.dart';
import 'package:new_version_plus/new_version_plus.dart';

import '../widget/new.version.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final newVersion = NewVersionPlus(
    androidId: 'vn.doitsolutions.honors_app',
    iOSId: 'vn.doitsolutions.honorsApp',
  );
  @override
  void initState() {
    super.initState();
    checkNewVersion();
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
            Image.asset(AppImage.logo),
            const SizedBox(height: 40),
            const Text(
              AppText.nameApp,
              style: TextStyle(
                  fontSize: 25,
                  color: AppColor.secondary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                AppText.desApp,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: AppColor.secondary,
                    fontWeight: FontWeight.w100),
              ),
            ),
            const Spacer(),
            BacsicButton(
                onPressed: () {
                  start(context);
                },
                primary: true,
                label: AppText.btStart,
                width: width * 0.85),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  void start(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
