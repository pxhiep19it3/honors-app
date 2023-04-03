import 'package:flutter/material.dart';

import '../../../common/values/app.colors.dart';
import '../../core.value/screen/core.value.screen.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listTitle = [
      'Thành viên nhóm',
      'Giá trị cốt lõi',
      'Chính sách',
      'Quyền riêng tư',
    ];
    List listIcon = const [
      Icon(Icons.group, color: AppColor.black),
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
      myGroup(context);
    } else if (listTitle[index] == listTitle[1]) {
      coreValue(context);
    } else if (listTitle[index] == listTitle[2]) {
    } else if (listTitle[index] == listTitle[3]) {}
  }

  void myGroup(BuildContext context) {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (_) => const GroupScreen(nameWorkspace: 'Doit Solution', listMember: [],)));
  }

  void coreValue(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const CoreValueScreen(
                isFirst: false, automaticallyImplyLeading: true)));
  }
}