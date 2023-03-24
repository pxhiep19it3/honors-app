import 'package:flutter/material.dart';
import 'package:honors_app/modules/auth/screen/landing.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Honors App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue, fontFamily: 'Poppins'),
      home: const LandingScreen(),
    );
  }
}
