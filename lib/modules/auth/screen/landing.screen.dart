import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/common/values/app.images.dart';
import 'package:honors_app/common/values/app.text.dart';
import 'package:honors_app/common/widgets/basic.button.dart';
import 'package:honors_app/modules/auth/screen/login.screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

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
