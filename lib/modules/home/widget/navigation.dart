import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/modules/core.value/screen/core.value.screen.dart';
import 'package:honors_app/modules/profile/screen/group.screen.dart';

import '../../auth/screen/login.screen.dart';

class NavigationItems extends StatelessWidget {
  const NavigationItems({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listTitle = [
      'Thành viên nhóm',
      'Giá trị cốt lõi',
      'Chính sách',
      'Quyền riêng tư',
      'Đăng xuất'
    ];
    List listIcon = const [
      Icon(Icons.group, color: AppColor.secondary),
      Icon(Icons.accessibility_new, color: AppColor.secondary),
      Icon(Icons.chrome_reader_mode, color: AppColor.secondary),
      Icon(Icons.security, color: AppColor.secondary),
      Icon(Icons.logout, color: AppColor.secondary)
    ];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listTitle.length,
      itemBuilder: (BuildContext context, index) {
        return ListTile(
          onTap: () {
            onTap(context, listTitle, index);
          },
          leading: listIcon[index],
          title: Text(
            listTitle[index],
            style: const TextStyle(fontSize: 14, color: AppColor.secondary),
          ),
        );
      },
    );
  }

  void onTap(BuildContext context, List<String> listTitle, int index) {
    if (listTitle[index] == listTitle[0]) {
      myGroup(context);
    } else if (listTitle[index] == listTitle[1]) {
      coreValue(context);
    } else if (listTitle[index] == listTitle[2]) {
    } else if (listTitle[index] == listTitle[3]) {
    } else if (listTitle[index] == listTitle[4]) {
      logout(context);
    }
  }

  void myGroup(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const GroupScreen(title: 'Doit Solution')));
  }

  void coreValue(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const CoreValueScreen(
                  isFirst: false,
                )));
  }

  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
