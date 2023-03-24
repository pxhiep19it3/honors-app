import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/common/values/app.icons.dart';
import 'package:honors_app/common/values/app.text.dart';
import 'package:honors_app/modules/core.value/screen/core.value.screen.dart';

import '../../../common/widgets/basic.button.dart';

class SentEmailScreen extends StatelessWidget {
  const SentEmailScreen({
    super.key,
    required this.users,
    required this.isFirst
  });
  final List<String> users;
  final bool isFirst;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Image.asset(AppIcon.sendDone),
            const SizedBox(
              height: 20,
            ),
            const Text(
              AppText.titleSentEmail,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.2),
              child: ListView.builder(
                  itemCount: users.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Image.asset(AppIcon.addDone),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          users[index],
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            const Spacer(),
         isFirst ?   BacsicButton(
                onPressed: () {
                  continute(context);
                },
                label: AppText.btContinute,
                width: width * 0.85,
                primary: false) : Container(),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  void continute(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const CoreValueScreen(
                  isFirst: true,
                )));
  }
}
