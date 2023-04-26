// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:honors_app/modules/chart/provider/get.best.provider.dart';
import 'package:honors_app/modules/chart/provider/set.best.provider.dart';
import 'package:honors_app/modules/chart/provider/value.best.provider.dart';
import 'package:honors_app/modules/home/provider/home.provider.dart';
import 'package:honors_app/modules/workspace/provider/workspace.provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'modules/auth/screen/check.login.dart';
import 'modules/information/provider/management.provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dv = ['13B3C4E7640A4C8135687E60B1F5FEF0'];
  await MobileAds.instance.initialize();
  RequestConfiguration requestConfiguration =
      RequestConfiguration(testDeviceIds: dv);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => WorkspaceProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomeProvider(),
    ),
    ChangeNotifierProvider(create: (context) => ManagementProvider()),
    ChangeNotifierProvider(create: (context) => ValueBestProvider()),
    ChangeNotifierProvider(create: (context) => SetBestProvider()),
    ChangeNotifierProvider(create: (context) => GetBestProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Honors App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
      home: const CheckLogin(),
    );
  }
}
