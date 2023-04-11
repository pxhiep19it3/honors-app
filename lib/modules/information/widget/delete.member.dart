import 'package:flutter/material.dart';
import '../../../common/values/app.colors.dart';

class DeleteMember extends StatelessWidget {
  const DeleteMember(
      {super.key, required this.member, required this.deleteMember});
  final String member;
  final VoidCallback deleteMember;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.gray,
      title: const Center(
          child: Text(
        'Xóa thành viên này khỏi nhóm?',
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
          child: const Text('Thoát', style: TextStyle(color: AppColor.primary),),
        ),
        TextButton(
          onPressed: () {
            deleteMember();
            Navigator.pop(context, 'Xóa');
          },
          child: const Text('Xóa', style: TextStyle(color: AppColor.primary),),
        ),
      ],
    );
  }
}
