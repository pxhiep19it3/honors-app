import 'package:flutter/material.dart';
import 'package:honors_app/models/workspace.dart';
import '../../../common/values/app.colors.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key, required this.workspace});
  final Workspace workspace;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: Text(workspace.name ?? ''),
        actions: [
          IconButton(
              onPressed: () {
                addUser(context);
              },
              icon: const Icon(Icons.group_add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: workspace.members!.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      workspace.members![index],
                      style:
                          const TextStyle(color: AppColor.black, fontSize: 18),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {
                        trailing(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 10,
                    thickness: 2,
                  )
                ],
              );
            }),
      ),
    );
  }

  void addUser(BuildContext context) {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (_) => const AddUserScreen(
    //               isFirst: false,
    //             )));
  }

  void trailing(BuildContext context) {
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
                  onTap: () {},
                  leading: const Icon(Icons.compare_arrows_rounded),
                  title: const Text(
                    'Chuyển quyền',
                    style: TextStyle(fontSize: 18, color: AppColor.black),
                  ),
                ),
                ListTile(
                  onTap: () {},
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
}
