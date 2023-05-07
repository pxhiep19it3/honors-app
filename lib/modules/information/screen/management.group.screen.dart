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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: ListView(shrinkWrap: true, children: [
                  item(model, 'Tên nhóm: ', model.nameCtl!, false),
                  item(model, 'Địa chỉ: ', model.addressCtl!, false),
                  item(model, 'Số điện thoại: ', model.phoneCtl!, false),
                  item(model, 'Lĩnh vực: ', model.careerCtl!, false),
                  item(model, 'Số nhân viên: ', model.numberStaffCtl!, true),
                  item(model, 'Doanh thu:  ', model.revenueCtl!, true),
                  item(model, 'Khoá học đã tham gia:  ', model.courseJoinedCtl!,
                      true),
                  item(model, 'Quản trị:', model.adminCtl!, true),
                  const SizedBox(
                    height: 20,
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

  Widget item(ManagementProvider model, String title,
      TextEditingController controller, bool optional) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: AppColor.black, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(
          height: 10,
        ),
        BasicText(
            controller: controller,
            isContent: false,
            optional: optional,
            enabled: model.isAdmin ? true : false,
            isDetail: true),
        const SizedBox(
          height: 20,
        ),
      ],
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
