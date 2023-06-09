import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/common/values/app.images.dart';
import 'package:honors_app/common/values/app.text.dart';
import 'package:honors_app/modules/auth/widget/button.login.dart';
import 'package:provider/provider.dart';
import '../provider/auth.provider.dart';
import 'logineds.screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthModel _authModel = AuthModel();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<AuthModel>(
      create: ((context) => _authModel),
      builder: ((context, child) =>
          Consumer<AuthModel>(builder: (context, model, child) {
            Future.delayed(Duration.zero, () {
              if (_authModel.user != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            LoginedScreen(user: _authModel.user!)));
              }
            });
            return Scaffold(
              backgroundColor: AppColor.primary,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Image.asset(
                    AppImage.logo,
                    width: 126,
                    height: 133,
                  ),
                  // const SizedBox(height: 40),
                  // const Text(
                  //   AppText.nameApp,
                  //   style: TextStyle(
                  //       fontSize: 25,
                  //       color: AppColor.secondary,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Được bảo trợ bởi',
                    style: TextStyle(
                        fontSize: 25,
                        color: AppColor.secondary,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImage.logoDoit,
                        height: 50,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Image.asset(
                        AppImage.logoUdoo,
                        height: 50,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    AppImage.logoVKT,
                    height: 50,
                  ),

                  const Spacer(),
                  LoginButton(
                      onPressed: login, label: AppText.btLogin, width: width),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            );
          })),
    );
  }

  void login() async {
    _authModel.signInWithGoogle();
  }
}
