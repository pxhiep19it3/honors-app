import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem(
      {super.key, required this.nameWorkspace, required this.onTap});
  final String nameWorkspace;
  final Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    List<String> listTitle = [
      'Giá trị vinh danh nhiều nhất',
      'Vinh danh nhiều nhất',
      'Được vinh danh nhiều nhất',
    ];
    List listIcon = const [
      Icon(Icons.chrome_reader_mode, color: AppColor.secondary),
      Icon(Icons.accessibility_new, color: AppColor.secondary),
      Icon(Icons.insert_emoticon_sharp, color: AppColor.secondary),
    ];
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Text(
          nameWorkspace,
          style: const TextStyle(
              fontSize: 25,
              color: AppColor.secondary,
              fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: listTitle.length,
          itemBuilder: (BuildContext context, index) {
            return ListTile(
              onTap: () {
                onTap(index);
                Navigator.pop(context);
              },
              leading: listIcon[index],
              title: Text(
                listTitle[index],
                style: const TextStyle(fontSize: 14, color: AppColor.secondary),
              ),
            );
          },
        ),
      ],
    );
  }
}
