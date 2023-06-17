import 'package:flutter/material.dart';
import 'package:honors_app/modules/information/screen/member.group.screen.dart';
import 'package:honors_app/modules/information/screen/policy.screen.dart';
import 'package:honors_app/modules/information/screen/privacy.screen.dart';
import 'package:honors_app/modules/information/screen/update.pro.screen.dart';

import '../../../common/values/app.colors.dart';
import '../../core.value/screen/core.value.screen.dart';
import '../../set.hornors/screen/set.hornors.screen.dart';
import '../../sponsors/sponsors.screen.dart';
import '../screen/management.group.screen.dart';

class InformationItem extends StatefulWidget {
  const InformationItem({super.key, required this.emailLogin});
  final String emailLogin;

  @override
  State<InformationItem> createState() => _InformationItemState();
}

class _InformationItemState extends State<InformationItem> {
  @override
  Widget build(BuildContext context) {
    List<String> listTitle = [
      'Thông tin nhóm',
      'Thành viên nhóm',
      'Lịch sử vinh danh',
      'Giá trị cốt lõi',
      'Các nhà bảo trợ',
      'Chính sách',
      'Quyền riêng tư',
      // 'Nâng cấp gói'
    ];
    List listIcon = const [
      Icon(Icons.info_rounded, color: AppColor.primary),
      Icon(Icons.manage_accounts, color: AppColor.primary),
      Icon(Icons.insert_emoticon_sharp, color: AppColor.primary),
      Icon(Icons.accessibility_new, color: AppColor.primary),
      Icon(Icons.beenhere, color: AppColor.primary),
      Icon(Icons.chrome_reader_mode, color: AppColor.primary),
      Icon(Icons.security, color: AppColor.primary),
      // Icon(Icons.cloud_upload, color: AppColor.black),
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
                  style: const TextStyle(fontSize: 14, color: AppColor.primary),
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
      managerGroup();
    }
    if (listTitle[index] == listTitle[1]) {
      memberGroup();
    } else if (listTitle[index] == listTitle[2]) {
      setHornors();
    } else if (listTitle[index] == listTitle[3]) {
      coreValue();
    } else if (listTitle[index] == listTitle[4]) {
      sponsors();
    } else if (listTitle[index] == listTitle[5]) {
      policy();
    } else if (listTitle[index] == listTitle[6]) {
      privacy();
    } else {
      // updatePro(context);
    }
  }

  void setHornors() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const SetHornorsScreen()));
  }

  void memberGroup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const MemberGroupScreen()));
  }

  void updatePro() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const UpdateProScreen()));
  }

  void managerGroup() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const ManagementGroupScreen()));
  }

  void coreValue() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const CoreValueScreen(
                isFirst: false, automaticallyImplyLeading: true)));
  }

  void policy() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PolicyScreen()),
    );
  }

  void privacy() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const PrivacyScreen()));
  }

  void sponsors() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const SponsorsScreen()));
  }
}
