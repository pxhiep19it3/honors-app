import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/modules/auth/provider/check.login.provider.dart';
import 'package:honors_app/modules/auth/screen/landing.screen.dart';
import 'package:honors_app/modules/auth/screen/logineds.screen.dart';
import 'package:honors_app/modules/bottom/bottom.navigation.dart';
import 'package:provider/provider.dart';

class CheckLogin extends StatefulWidget {
  const CheckLogin({super.key});

  @override
  State<CheckLogin> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  CheckLoginProvider provider = CheckLoginProvider();

  @override
  void initState() {
    provider.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckLoginProvider>(
      create: (context) => provider,
      builder: (context, child) {
        return Consumer<CheckLoginProvider>(
          builder: (context, model, child) {
            if (model.isSignedIn && model.isInWorkspace) {
              return const BottomNavigation();
            } else if (model.isSignedIn && !model.isInWorkspace) {
              return model.user != null
                  ? LoginedScreen(
                      user: model.user!,
                    )
                  : const Scaffold(
                      backgroundColor: AppColor.primary,
                      body: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.secondary,
                          strokeWidth: 2,
                        ),
                      ),
                    );
            } else {
              return const LandingScreen();
            }
          },
        );
      },
    );
  }
}
