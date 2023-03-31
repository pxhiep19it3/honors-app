import 'package:flutter/material.dart';

import '../../../common/values/app.colors.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: Text(title),
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
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Phan Xuân Hiệp',
                      style: TextStyle(color: AppColor.black, fontSize: 20),
                    ),
                    subtitle: const Text('hiepphan197420@gmail.com'),
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
          height: 200,
          color: AppColor.gray,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => GroupScreen(title: title)));
                  },
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
