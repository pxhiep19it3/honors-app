import 'package:flutter/material.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/values/app.images.dart';
import '../../auth/screen/login.screen.dart';
import '../widget/profile.item.screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                Image.asset(
                  AppImage.testLogo,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Phan Xuân Hiệp',
                  style: TextStyle(
                      fontSize: 25,
                      color: AppColor.secondary,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'hiepphan197420@gmail.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColor.secondary,
                      fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
          const Expanded(child: ProfileItem()),
        ],
      ),
    );
  }

  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
