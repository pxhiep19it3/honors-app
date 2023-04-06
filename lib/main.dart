import 'package:flutter/material.dart';
import 'package:honors_app/modules/auth/screen/landing.screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:honors_app/modules/home/provider/home.provider.dart';
import 'package:honors_app/modules/workspace/provider/workspace.provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => WorkspaceProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Honors App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
      home: const LandingScreen(),
    );
  }
}
