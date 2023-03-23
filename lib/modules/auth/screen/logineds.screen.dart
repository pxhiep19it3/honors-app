import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/common/values/app.images.dart';
import 'package:honors_app/common/values/app.text.dart';
import 'package:honors_app/common/widgets/basic.button.dart';
import 'package:honors_app/modules/workspace/screen/create.workspace.dart';

class LoginedScreen extends StatelessWidget {
  const LoginedScreen({super.key});

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
            Image.asset(AppImage.testLogo),
            const SizedBox(height: 20),
            const Text(
              'Phan Xuân Hiệp',
              style: TextStyle(
                  fontSize: 25,
                  color: AppColor.secondary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'hiepphan197420@gmail.com',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: AppColor.secondary,
                  fontWeight: FontWeight.w100),
            ),
            const Spacer(),
            BacsicButton(
                onPressed: () {
                  create(context);
                },
                label: AppText.btCreateNew,
                width: width * 0.85,
                primary: true),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  AppText.btJoin,
                  style: TextStyle(
                      color: AppColor.secondary,
                      fontSize: 18,
                      decoration: TextDecoration.underline),
                )),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }

  void create(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CreateWorkspaceScreen()));
  }
}
