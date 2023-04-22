import 'package:flutter/material.dart';
import 'package:honors_app/models/workspace.dart';
import 'package:honors_app/modules/workspace/provider/workspace.provider.dart';

import '../../../common/values/app.colors.dart';

class OutWorkspace extends StatefulWidget {
  const OutWorkspace(
      {super.key,
      required this.workspace,
      required this.model,
      required this.isAdmin});
  final Workspace workspace;
  final WorkspaceProvider model;
  final bool isAdmin;

  @override
  State<OutWorkspace> createState() => _OutWorkspaceState();
}

class _OutWorkspaceState extends State<OutWorkspace> {
  String newAdmin = '';
  @override
  void initState() {
    super.initState();
    setState(() {
      newAdmin = widget.workspace.members![0];
    });
  }

  void setAdmin(String? value) {
    setState(() {
      newAdmin = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.gray,
      title: !widget.isAdmin
          ? const Center(
              child: Text(
              textAlign: TextAlign.center,
              'Bạn có chắc chắn rời khỏi nhóm?',
              style: TextStyle(color: AppColor.primary),
            ))
          : const Center(
              child: Text(
              textAlign: TextAlign.center,
              'Chọn quản trị mới',
              style: TextStyle(color: AppColor.primary),
            )),
      content: _buildContent(context),
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
          child:
              const Text('Rời khỏi', style: TextStyle(color: AppColor.primary)),
          onPressed: () {
            widget.model.outWorkspace(
                widget.workspace.id ?? '', widget.isAdmin, newAdmin);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return !widget.isAdmin
        ? SizedBox(
            height: 100,
            child: Center(child: Text(widget.workspace.name ?? '')))
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: const Border(
                left: BorderSide(width: 1.0, color: AppColor.black),
                right: BorderSide(width: 1.0, color: AppColor.black),
                bottom: BorderSide(width: 1.0, color: AppColor.black),
                top: BorderSide(width: 1.0, color: AppColor.black),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: newAdmin,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: AppColor.black),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: setAdmin,
                items: widget.workspace.members!
                    .cast<String>()
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
  }
}
