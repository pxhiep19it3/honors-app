import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../common/values/app.colors.dart';
import '../../../service/remote.config.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseRemoteConfig>(
        future: RemoteConfigRepo.setupRemoteConfig(),
        builder: (BuildContext context,
            AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
          return snapshot.hasData
              ? Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColor.primary,
                    centerTitle: true,
                    title: const Text('Chính sách'),
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                  ),
                  body: InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: Uri.parse(
                            snapshot.requireData.getString('policy'))),
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
