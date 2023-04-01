import 'package:flutter/material.dart';
import 'package:honors_app/models/workspace.dart';
import 'package:honors_app/modules/workspace/provider/workspace.provider.dart';
import 'package:provider/provider.dart';

import '../../../common/values/app.colors.dart';
import '../../profile/screen/group.screen.dart';
import '../widget/out.workspace.dart';

class GroupJoined extends StatefulWidget {
  const GroupJoined({super.key});

  @override
  State<GroupJoined> createState() => _GroupJoinedState();
}

class _GroupJoinedState extends State<GroupJoined> {
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
        return Scaffold(
            backgroundColor: AppColor.secondary,
            appBar: AppBar(
              backgroundColor: AppColor.primary,
              centerTitle: true,
              title: const Text('Nhóm đã tham gia'),
            ),
            body: model.listWorkspace.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.listWorkspace.length,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        onTap: () {},
                        title: Text(
                          model.listWorkspace[index].name ?? '',
                          style: const TextStyle(
                              fontSize: 18, color: AppColor.black),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              trailing(model.listWorkspace[index], model);
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: AppColor.black,
                            )),
                      );
                    },
                  )
                : const Center(
                    child: Text('Chưa có dữ liệu!'),
                  ));
      }),
    );
  }

  void trailing(Workspace workspace, WorkspaceProvider model) {
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
                    style: const TextStyle(fontSize: 18, color: AppColor.black),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                GroupScreen(title: workspace.name ?? '')));
                  },
                  leading: const Icon(Icons.group_add),
                  title: const Text(
                    'Thêm thành viên',
                    style: TextStyle(fontSize: 18, color: AppColor.black),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    // if (model.emailLogin == workspace.admin) {
                    //   model.setListMemberOut(workspace.members!);
                    // }
                    await out(workspace, model);
                    // ignore: use_build_context_synchronously
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
                          await out(workspace, model);
                          // ignore: use_build_context_synchronously
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
}