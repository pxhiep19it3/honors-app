import 'package:flutter/material.dart';
import 'package:honors_app/common/widgets/basic.text.dart';
import 'package:provider/provider.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/values/app.icons.dart';
import '../provider/management.provider.dart';
import 'add.user.screen.dart';
import '../widget/delete.workspace.dart';
import '../widget/member.item.dart';

class ManagementGroupScreen extends StatefulWidget {
  const ManagementGroupScreen({super.key});

  @override
  State<ManagementGroupScreen> createState() => _ManagementGroupScreenState();
}

class _ManagementGroupScreenState extends State<ManagementGroupScreen> {
  ManagementProvider provider = ManagementProvider();
  @override
  void initState() {
    super.initState();
    provider.init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ManagementProvider>(
      create: ((context) => provider),
      builder: (context, child) {
        return Consumer<ManagementProvider>(builder: (context, model, child) {
          return Scaffold(
            backgroundColor: AppColor.secondary,
            appBar: AppBar(
              backgroundColor: AppColor.primary,
              centerTitle: true,
              title: const Text('Quản lý nhóm'),
              actions: [
                model.isAdmin
                    ? IconButton(
                        onPressed: model.updateWorkspace,
                        icon: const Icon(Icons.check))
                    : Container(),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(shrinkWrap: true, children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Tên nhóm: ',
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                BasicText(
                    controller: model.nameCtl!,
                    isContent: false,
                    enabled: model.isAdmin ? true : false,
                    isDetail: true),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Địa chỉ: ',
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                BasicText(
                    controller: model.addressCtl!,
                    isContent: false,
                    enabled: model.isAdmin ? true : false,
                    isDetail: true),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Lĩnh vực: ',
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                BasicText(
                    controller: model.careerCtl!,
                    isContent: false,
                    enabled: model.isAdmin ? true : false,
                    isDetail: true),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Quản trị: ',
                  style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                BasicText(
                    controller: model.adminCtl!,
                    isContent: false,
                    enabled: false,
                    isDetail: true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Thành viên nhóm:',
                      style: TextStyle(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        addUser(model);
                      },
                      child: Image.asset(
                        AppIcon.addMember,
                        width: 70,
                        height: 70,
                      ),
                    )
                  ],
                ),
                model.workspace != null
                    ? MemberItem(
                        workspace: model.workspace!,
                        model: model,
                      )
                    : Container(),
                model.isAdmin
                    ? TextButton(
                        onPressed: () {
                          deleteWorkspace(model.nameCtl!.text, model);
                        },
                        child: Text('Xoá'))
                    : Container(),
              ]),
            ),
          );
        });
      },
    );
  }

  Future deleteWorkspace(String nameWorkspace, ManagementProvider model) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DeleteWorkspace(
          nameWorkspace: nameWorkspace,
          deleteWorkspace: () {
            model.deleteWorkspace(model.workspace!.members!.cast<String>());
          },
        );
      },
    );
  }

  void addUser(ManagementProvider model) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddUserScreen(
            model: model,
          ),
        ));
  }
}
