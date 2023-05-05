import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/values/app.colors.dart';
import '../provider/management.provider.dart';
import '../widget/member.item.dart';
import 'add.user.screen.dart';

class MemberGroupScreen extends StatefulWidget {
  const MemberGroupScreen({super.key});

  @override
  State<MemberGroupScreen> createState() => _MemberGroupScreenState();
}

class _MemberGroupScreenState extends State<MemberGroupScreen> {
  ManagementProvider provider = ManagementProvider();
  final form = GlobalKey<FormState>();

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
          return Form(
            key: form,
            child: Scaffold(
                backgroundColor: AppColor.secondary,
                appBar: AppBar(
                  backgroundColor: AppColor.primary,
                  centerTitle: true,
                  title: const Text('Thành viên nhóm'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          addUser(model);
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      model.workspace != null
                          ? MemberItem(
                              workspace: model.workspace!,
                              model: model,
                            )
                          : Container(),
                    ],
                  ),
                )),
          );
        });
      },
    );
  }

  void addUser(ManagementProvider model) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddUserScreen(
            model: model,
          ),
        ));
  }
}
