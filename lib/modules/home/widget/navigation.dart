import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/modules/core.value/screen/core.value.screen.dart';

import '../../auth/screen/login.screen.dart';
import '../../information/screen/policy.screen.dart';
import '../../information/screen/privacy.screen.dart';

class NavigationItems extends StatelessWidget {
  const NavigationItems({super.key});
 
  @override
  Widget build(BuildContext context) {
    List<String> listTitle = [
      'Giá trị cốt lõi',
      'Chính sách',
      'Quyền riêng tư',
      'Đăng xuất'
    ];
    List listIcon = const [
      Icon(Icons.accessibility_new, color: AppColor.secondary),
      Icon(Icons.chrome_reader_mode, color: AppColor.secondary),
      Icon(Icons.security, color: AppColor.secondary),
      Icon(Icons.logout, color: AppColor.secondary)
    ];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listTitle.length,
      itemBuilder: (BuildContext context, index) {
        return ListTile(
          onTap: () {
            onTap(context, listTitle, index);
          },
          leading: listIcon[index],
          title: Text(
            listTitle[index],
            style: const TextStyle(fontSize: 14, color: AppColor.secondary),
          ),
        );
      },
    );
  }

  void onTap(BuildContext context, List<String> listTitle, int index) {
    if (listTitle[index] == listTitle[0]) {
      coreValue(context);
    } else if (listTitle[index] == listTitle[1]) {
      policy(context);
    } else if (listTitle[index] == listTitle[2]) {
      privacy(context);
    } else if (listTitle[index] == listTitle[3]) {
      logout(context);
    }
  }

  void coreValue(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const CoreValueScreen(
                isFirst: false, automaticallyImplyLeading: true)));
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

   void policy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PolicyScreen()),
    );
  }

  void privacy(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const PrivacyScreen()));
  }

  
}
