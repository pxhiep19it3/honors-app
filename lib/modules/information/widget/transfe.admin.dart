import 'package:flutter/material.dart';
import '../../../common/values/app.colors.dart';

class TransfeAdmin extends StatelessWidget {
  const TransfeAdmin(
      {super.key, required this.member, required this.transfeAdmin});
  final String member;
  final VoidCallback transfeAdmin;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.gray,
      title: const Center(
          child: Text(
        'Chuyển quyền quản trị cho thành viên này?',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColor.primary),
      )),
      content: SizedBox(
        height: 100,
        child: Center(
          child: Text(member),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Thoát'),
          child: const Text(
            'Thoát',
            style: TextStyle(color: AppColor.primary),
          ),
        ),
        TextButton(
          onPressed: () {
            transfeAdmin();
            Navigator.pop(context, 'Chuyển');
          },
          child: const Text(
            'Chuyển',
            style: TextStyle(color: AppColor.primary),
          ),
        ),
      ],
    );
  }
}
