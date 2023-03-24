import 'package:flutter/material.dart';

import '../../../../common/values/app.colors.dart';
import '../../../common/values/app.images.dart';
import '../../../common/widgets/hornors.item.dart';
import '../../../common/widgets/show.score.dart';
import '../../home/screen/detail.home.screen.dart';
import '../../home/widget/hornors.dart';
import '../../../common/widgets/detail.hornors.dart';

class GetHornorsScreen extends StatelessWidget {
  const GetHornorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Được vinh danh'),
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.35,
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
                const Text(
                  'Phan Xuân Hiệp',
                  style: TextStyle(
                      fontSize: 25,
                      color: AppColor.secondary,
                      fontWeight: FontWeight.bold),
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
                      child: HonorsItems(isHome: false, isGet: true),
                    )),
          ),
        ],
      ),
    );
  }

  void onTap(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                const DetailHornorsScreen(title: 'Phan Xuân Hiệp')));
  }

  void favorite(BuildContext context) {
    showDialog<String>(
        context: context, builder: (BuildContext context) => const Hornors());
  }

  void preview(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const DetailHomeScreen()));
  }
}
