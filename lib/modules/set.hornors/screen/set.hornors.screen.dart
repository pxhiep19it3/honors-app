import 'package:flutter/material.dart';
import '../../../../common/values/app.colors.dart';
import '../../../common/widgets/hornors.item.dart';
import '../../home/widget/hornors.dart';
import '../../profile/screen/profile.screen.dart';
import 'detail.Set.hornors.dart';

class SetHornorsScreen extends StatelessWidget {
  const SetHornorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Đã vinh danh'),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (BuildContext context, index) => const Padding(
                padding: EdgeInsets.all(20.0),
                child: HonorsItems(
                  isHome: false,
                ),
              )),
    );
  }

  void onTap(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                const DetailSetHornorsScreen(title: 'Phan Xuân Hiệp')));
  }

  void favorite(BuildContext context) {
    showDialog<String>(
        context: context, builder: (BuildContext context) => const Hornors());
  }

  void preview(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const Profile()));
  }
}
