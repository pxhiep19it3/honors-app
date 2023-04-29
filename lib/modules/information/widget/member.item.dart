import 'package:flutter/material.dart';
import 'package:honors_app/models/workspace.dart';
import 'package:honors_app/modules/information/provider/management.provider.dart';
import 'package:honors_app/modules/information/widget/transfe.admin.dart';
import '../../../common/values/app.colors.dart';
import 'delete.member.dart';

class MemberItem extends StatelessWidget {
  const MemberItem({super.key, required this.workspace, required this.model});
  final Workspace workspace;
  final ManagementProvider model;

  @override
  Widget build(BuildContext context) {
    return workspace.members!.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            itemCount: workspace.members!.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColor.gray,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                          title: Text(
                            workspace.members![index],
                            style: const TextStyle(color: AppColor.black),
                          ),
                          trailing: model.isAdmin
                              ? IconButton(
                                  icon: const Icon(Icons.more_vert),
                                  onPressed: () {
                                    trailing(
                                        context, workspace.members![index]);
                                  },
                                )
                              : const SizedBox(
                                  height: 2,
                                  width: 2,
                                )),
                    ],
                  ),
                ),
              );
            })
        : const Center(
            child: Text('Chưa có thành viên!'),
          );
  }

  void trailing(
    BuildContext context,
    String member,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          color: AppColor.gray,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    transfeAdmin(context, member);
                  },
                  leading: const Icon(Icons.compare_arrows_rounded),
                  title: const Text(
                    'Chuyển quyền',
                    style: TextStyle(fontSize: 18, color: AppColor.black),
                  ),
                ),
                ListTile(
                  onTap: () {
                    deleteMember(context, member);
                  },
                  leading: const Icon(Icons.remove_circle),
                  title: const Text(
                    'Xóa khỏi nhóm',
                    style: TextStyle(fontSize: 18, color: AppColor.black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future deleteMember(BuildContext context, String member) async {
    Navigator.pop(context, 'Xóa');
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DeleteMember(
          member: member,
          deleteMember: () {
            model.deleteMember(member);
          },
        );
      },
    );
  }

  Future transfeAdmin(BuildContext context, String member) async {
    Navigator.pop(context, 'Xóa');
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return TransfeAdmin(
          member: member,
          transfeAdmin: () {
            model.transfeAdmin(member);
          },
        );
      },
    );
  }
}
