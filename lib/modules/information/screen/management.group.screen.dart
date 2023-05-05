import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:honors_app/common/widgets/basic.text.dart';
import 'package:provider/provider.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/widgets/basic.button.dart';
import '../provider/management.provider.dart';
import '../widget/delete.workspace.dart';

class ManagementGroupScreen extends StatefulWidget {
  const ManagementGroupScreen({super.key});

  @override
  State<ManagementGroupScreen> createState() => _ManagementGroupScreenState();
}

class _ManagementGroupScreenState extends State<ManagementGroupScreen> {
  ManagementProvider provider = ManagementProvider();
  final form = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    provider.init();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                title: const Text('Thông tin nhóm'),
                actions: [
                  model.isAdmin
                      ? IconButton(
                          onPressed: () {
                            deleteWorkspace(model.nameWorkspace ?? '', model);
                          },
                          icon: const Icon(Icons.delete))
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
                  const SizedBox(
                    height: 40,
                  ),
                  model.isAdmin
                      ? BacsicButton(
                          onPressed: () {
                            update(model);
                          },
                          primary: false,
                          label: 'CẬP NHẬT',
                          width: width * 0.85)
                      : Container(),
                ]),
              ),
            ),
          );
        });
      },
    );
  }

  Future deleteWorkspace(String nameWorkspace, ManagementProvider model) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DeleteWorkspace(
          nameWorkspace: nameWorkspace,
          deleteWorkspace: () {
            model.deleteWorkspace(
              model.workspace!.members!.cast<String>(),
            );
          },
        );
      },
    );
  }

  void update(ManagementProvider model) {
    if (form.currentState!.validate()) {
      model.updateWorkspace();
      Flushbar(
        message: "Đã cập nhật!",
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue[300],
        ),
        duration: const Duration(seconds: 2),
        leftBarIndicatorColor: Colors.blue[300],
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height -
                MediaQuery.of(context).size.height * 0.5,
            right: 20,
            left: 20),
      ).show(context);
    }
  }
}
