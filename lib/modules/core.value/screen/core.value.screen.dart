import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/common/values/app.text.dart';
import 'package:honors_app/modules/bottom/bottom.navigation.dart';
import 'package:honors_app/modules/core.value/screen/detail.value.screen.dart';
import 'package:honors_app/modules/core.value/widget/add.core.value.dart';
import 'package:honors_app/modules/core.value/widget/delete.core.value.dart';

import '../../../common/widgets/basic.button.dart';
import '../widget/core.value.item.dart';
import '../widget/score.setting.dart';

class CoreValueScreen extends StatelessWidget {
  const CoreValueScreen({super.key, required this.isFirst, required this.automaticallyImplyLeading});
  final bool isFirst;
  final bool automaticallyImplyLeading;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        automaticallyImplyLeading: automaticallyImplyLeading,
        centerTitle: true,
        title: const Text(AppText.titleCoreValue),
        actions: [
          IconButton(
              onPressed: () {
                create(context);
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                settingScore(context);
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CoreValueItem(
                        onTap: () {
                          onTap(context, 'Giá trị cối lõi');
                        },
                      ),
                    );
                  }),
            ),
            isFirst
                ? BacsicButton(
                    onPressed: () {
                      done(context);
                    },
                    label: AppText.btDone,
                    width: width * 0.85,
                    primary: false)
                : Container()
          ],
        ),
      ),
    );
  }

  void settingScore(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => const ScoreSetting());
  }

  void done(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const BottomNavigation()));
  }

  void delete(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => const DeleteCoreValue(
              title: 'Tiêu đề',
            ));
  }

  void create(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => const AddCoreValue());
  }

  void onTap(BuildContext context, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => DetailCoreValue(
                  title: title,
                  delete: () {
                    delete(context);
                  },
                )));
  }
}
