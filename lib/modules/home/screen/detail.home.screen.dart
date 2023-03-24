import 'package:flutter/material.dart';
import 'package:honors_app/common/widgets/hornors.item.dart';
import '../../../../common/values/app.colors.dart';
import '../../../common/values/app.images.dart';

import '../../../common/widgets/show.score.dart';
import '../../home/widget/hornors.dart';

class DetailHomeScreen extends StatelessWidget {
  const DetailHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: const Text('Phan Xuân Hiệp'),
        actions: [
          IconButton(
              onPressed: () {
                favorite(context);
              },
              icon: const Icon(Icons.favorite))
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
                Image.asset(AppImage.testLogo),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'hiepphan197420@gmail.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColor.secondary,
                      fontWeight: FontWeight.w100),
                ),
                const SizedBox(
                  height: 10,
                ),
                const ShowScore(),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, index) => const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: HonorsItems(),
                    )),
          ),
        ],
      ),
    );
  }

  void onTap(BuildContext context) {}

  void favorite(BuildContext context) {
    showDialog<String>(
        context: context, builder: (BuildContext context) => const Hornors());
  }

  void preview(BuildContext context) {}
}
