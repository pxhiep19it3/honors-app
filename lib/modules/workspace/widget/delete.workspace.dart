// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:honors_app/models/workspace.dart';
import 'package:honors_app/modules/workspace/provider/workspace.provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/values/app.colors.dart';
import '../../auth/screen/login.screen.dart';

class DeleteWorkspace extends StatelessWidget {
  const DeleteWorkspace(
      {super.key,
      required this.workspace,
      required this.model,
      this.isFirst = false,
      this.notifyListener = false});
  final Workspace workspace;
  final WorkspaceProvider model;
  final bool isFirst;
  final bool notifyListener;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.gray,
      title: const Center(
          child: Text(
        textAlign: TextAlign.center,
        'Bạn có chắc chắn xóa nhóm này?',
        style: TextStyle(color: AppColor.primary),
      )),
      content: SizedBox(
        height: 50,
        child: Center(
          child: Text(workspace.name ?? ''),
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Thoát', style: TextStyle(color: AppColor.primary)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Xóa', style: TextStyle(color: AppColor.primary)),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            bool isCheck = prefs.getString('nameWorkspace') == workspace.name;
            model.deleteWorkspace(
                workspace.id ?? '',
                workspace.members!.cast<String>(),
                workspace.admin ?? '',
                notifyListener);
            if (isFirst) {
              Navigator.of(context).pop();
            } else {
              if (isCheck) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              } else {
                Navigator.of(context).pop();
              }
            }
          },
        ),
      ],
    );
  }
}
