// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/modules/workspace/widget/delete.workspace.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/workspace.dart';
import '../../bottom/bottom.navigation.dart';
import '../../workspace/provider/workspace.provider.dart';
import '../../workspace/widget/out.workspace.dart';

class WorkspaceItem extends StatefulWidget {
  const WorkspaceItem({super.key});

  @override
  State<WorkspaceItem> createState() => _WorkspaceItemState();
}

class _WorkspaceItemState extends State<WorkspaceItem> {
  final WorkspaceProvider _provider = WorkspaceProvider();

  @override
  void initState() {
    super.initState();
    _provider.getWorkspace();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WorkspaceProvider>(
      create: ((context) => _provider),
      builder: (context, child) =>
          Consumer<WorkspaceProvider>(builder: (context, model, child) {
        return model.listWorkspace.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: model.listWorkspace.length,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    onTap: () {
                      onTap(model, index);
                    },
                    title: Text(
                      model.listWorkspace[index].name ?? '',
                      style: const TextStyle(
                          fontSize: 18, color: AppColor.secondary),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          trailing(model.listWorkspace[index], model);
                        },
                        icon: const Icon(
                          Icons.more_vert,
                          color: AppColor.secondary,
                        )),
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      }),
    );
  }

  void onTap(WorkspaceProvider model, int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'nameWorkspace', model.listWorkspace[index].name ?? '');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavigation()),
      (Route<dynamic> route) => false,
    );
  }

  void trailing(
    Workspace workspace,
    WorkspaceProvider model,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: model.emailLogin == workspace.admin ? 280 : 200,
          color: AppColor.gray,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {},
                  title: Text(
                    workspace.name ?? '',
                    style:
                        const TextStyle(fontSize: 18, color: AppColor.primary),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    await out(workspace, model);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.logout),
                  title: const Text(
                    'Rời khỏi',
                    style: TextStyle(fontSize: 18, color: AppColor.black),
                  ),
                ),
                model.emailLogin == workspace.admin
                    ? ListTile(
                        onTap: () async {
                          await delete(workspace, model);
                          Navigator.pop(context);
                        },
                        leading: const Icon(Icons.delete),
                        title: const Text(
                          'Xóa nhóm',
                          style: TextStyle(fontSize: 18, color: AppColor.black),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        );
      },
    );
  }

  Future out(Workspace workspace, WorkspaceProvider model) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return OutWorkspace(
          workspace: workspace,
          model: model,
          isAdmin: model.emailLogin == workspace.admin,
        );
      },
    );
  }

  Future delete(Workspace workspace, WorkspaceProvider model) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DeleteWorkspace(
          workspace: workspace,
          model: model,
        );
      },
    );
  }
}
