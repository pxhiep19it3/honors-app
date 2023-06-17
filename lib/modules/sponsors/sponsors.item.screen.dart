import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../common/values/app.colors.dart';

class SponsorsItemScreen extends StatelessWidget {
  const SponsorsItemScreen(
      {super.key, required this.title, required this.link});
  final String title;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColor.primary,
            centerTitle: true,
            title: Text(title),
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios))),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(link)),
        ));
  }
}
