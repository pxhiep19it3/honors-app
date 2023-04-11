import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/values/app.colors.dart';
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

  @override
  void initState() {
    super.initState();
    init();
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
              child: InformationItem(
            emailLogin: _emailLogin ?? '',
          )),
        ],
      ),
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