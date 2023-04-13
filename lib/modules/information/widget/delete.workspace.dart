import 'package:flutter/material.dart';
import '../../../common/values/app.colors.dart';
import '../../auth/screen/login.screen.dart';

class DeleteWorkspace extends StatelessWidget {
  const DeleteWorkspace(
      {super.key, required this.nameWorkspace, required this.deleteWorkspace});
  final String nameWorkspace;
  final VoidCallback deleteWorkspace;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.gray,
      title: const Center(
          child: Text(
        'Bạn chắc chắn xóa nhóm này?',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColor.primary),
      )),
      content: SizedBox(
        height: 100,
        child: Center(
          child: Text(nameWorkspace),
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
            deleteWorkspace();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
            );
          },
          child: const Text(
            'Xóa',
            style: TextStyle(color: AppColor.primary),
          ),
        ),
      ],
    );
  }
}
