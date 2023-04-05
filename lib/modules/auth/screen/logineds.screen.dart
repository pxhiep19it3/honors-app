import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/common/values/app.text.dart';
import 'package:honors_app/common/widgets/basic.button.dart';
import 'package:honors_app/modules/auth/screen/login.screen.dart';
import 'package:honors_app/modules/workspace/screen/create.workspace.dart';

import '../../workspace/screen/group.joined.screen.dart';

class LoginedScreen extends StatelessWidget {
  const LoginedScreen({super.key, required this.user});
  final User user;

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
            CircleAvatar(
              radius: 110,
              backgroundImage: NetworkImage(user.photoURL ?? ''),
            ),
            const SizedBox(height: 20),
            Text(
              user.displayName ?? '',
              style: const TextStyle(
                  fontSize: 25,
                  color: AppColor.secondary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              user.email ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16,
                  color: AppColor.secondary,
                  fontWeight: FontWeight.w100),
            ),
            const Spacer(),
            BacsicButton(
                onPressed: () {
                  create(context, user.email ?? '');
                },
                label: AppText.btCreateNew,
                width: width * 0.85,
                primary: true),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  join(context, user.email ?? '');
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
              height: 80,
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
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => CreateWorkspaceScreen(
                admin: admin,
                user: user,
              )),
      (Route<dynamic> route) => false,
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
}
