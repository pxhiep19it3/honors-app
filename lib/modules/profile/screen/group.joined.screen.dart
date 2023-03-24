import 'package:flutter/material.dart';

import '../../../common/values/app.colors.dart';
import 'group.screen.dart';

class GroupJoined extends StatelessWidget {
  const GroupJoined({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      'VKU Group',
      'Doit Solution',
      'Danang University',
    ];
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: const Text('Nhóm đã tham gia'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            onTap: () {},
            title: Text(
              list[index],
              style: const TextStyle(fontSize: 18, color: AppColor.black),
            ),
            trailing: IconButton(
                onPressed: () {
                  trailing(context, list[index]);
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: AppColor.black,
                )),
          );
        },
      ),
    );
  }

  void trailing(BuildContext context, String title) {
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
                  onTap: () {},
                  title: Text(
                    title,
                    style: const TextStyle(fontSize: 18, color: AppColor.black),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => GroupScreen(title: title)));
                  },
                  leading: const Icon(Icons.group_add),
                  title: const Text(
                    'Thêm thành viên',
                    style: TextStyle(fontSize: 18, color: AppColor.black),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.logout),
                  title: const Text(
                    'Rời khỏi',
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
