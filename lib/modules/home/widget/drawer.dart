import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/modules/home/widget/workspace.dart';

import '../../../common/values/app.text.dart';
import 'navigation.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key, required this.nameWorkspace});
  final String nameWorkspace;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: AppColor.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.6,
            child: Column(
              children: const [
                SizedBox(
                  height: 40,
                ),
                Text(
                  AppText.workspaces,
                  style: TextStyle(
                      fontSize: 25,
                      color: AppColor.secondary,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(child: WorkspaceItem()),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 2,
            thickness: 1,
            color: AppColor.secondary,
          ),
          Expanded(
            child: NavigationItems(
              nameWorkspace: nameWorkspace,
            ),
          )
        ],
      ),
    );
  }
}
