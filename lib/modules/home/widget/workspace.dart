import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';

import '../../profile/screen/group.screen.dart';


class Workspace extends StatelessWidget {
  const Workspace({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      'VKU Group',
      'Doit Solution',
      'Danang University',
    ];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, index) {
        return ListTile(
          onTap: () {},
          title: Text(
            list[index],
            style: const TextStyle(fontSize: 18, color: AppColor.secondary),
          ),
          trailing: IconButton(
              onPressed: () {
                trailing(context, list[index]);
              },
              icon: const Icon(
                Icons.more_vert,
                color: AppColor.secondary,
              )),
        );
      },
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
