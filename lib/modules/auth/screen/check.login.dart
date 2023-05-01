import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
    requestPermission();
    initInFo();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initInFo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = const DarwinInitializationSettings();

    var initAll =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    flutterLocalNotificationsPlugin.initialize(initAll,
        onDidReceiveNotificationResponse: (NotificationResponse r) async {});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true);
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('Test', 'Test',
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              priority: Priority.high,
              playSound: true);
      NotificationDetails platForm = NotificationDetails(
          android: androidNotificationDetails,
          iOS: const DarwinNotificationDetails());
      await flutterLocalNotificationsPlugin.show(
          0, message.notification!.title, message.notification!.body, platForm,
          payload: message.data['title']);
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {}
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
