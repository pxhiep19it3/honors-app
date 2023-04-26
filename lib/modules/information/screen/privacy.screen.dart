import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../common/values/app.colors.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseRemoteConfig>(
        future: setupRemoteConfig(),
        builder: (BuildContext context,
            AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
          return snapshot.hasData
              ? Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColor.primary,
                    centerTitle: true,
                    title: const Text('Quyền riêng tư'),
                  ),
                  body: InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: Uri.parse(
                            snapshot.requireData.getString('privacy'))),
                  ))
              : const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primary,
                      strokeWidth: 2,
                    ),
                  ),
                );
        });
  }
}

Future<FirebaseRemoteConfig> setupRemoteConfig() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
  RemoteConfigValue(null, ValueSource.valueStatic);
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 1),
    minimumFetchInterval: const Duration(seconds: 1),
  ));
  return remoteConfig;
}
