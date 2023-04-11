import 'package:flutter/material.dart';

import '../../../common/values/app.colors.dart';
import '../../core.value/screen/core.value.screen.dart';
import '../screen/management.group.screen.dart';

class InformationItem extends StatelessWidget {
  const InformationItem({super.key, required this.emailLogin});
final String emailLogin;
  @override
  Widget build(BuildContext context) {
    List<String> listTitle = [
      'Quản lý nhóm',
      'Giá trị cốt lõi',
      'Chính sách',
      'Quyền riêng tư',
    ];
    List listIcon = const [
      Icon(Icons.manage_accounts, color: AppColor.black),
      Icon(Icons.accessibility_new, color: AppColor.black),
      Icon(Icons.chrome_reader_mode, color: AppColor.black),
      Icon(Icons.security, color: AppColor.black),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listTitle.length,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.gray, borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                onTap: () {
                  onTap(context, listTitle, index);
                },
                leading: listIcon[index],
                title: Text(
                  listTitle[index],
                  style: const TextStyle(fontSize: 14, color: AppColor.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void onTap(BuildContext context, List<String> listTitle, int index) {
    if (listTitle[index] == listTitle[0]) {
      managerGroup(context);
    } else if (listTitle[index] == listTitle[1]) {
      coreValue(context);
    } else if (listTitle[index] == listTitle[2]) {
    } else if (listTitle[index] == listTitle[3]) {}
  }

  void managerGroup(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const ManagementGroupScreen()));
  }

  void coreValue(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const CoreValueScreen(
                isFirst: false, automaticallyImplyLeading: true)));
  }
}
