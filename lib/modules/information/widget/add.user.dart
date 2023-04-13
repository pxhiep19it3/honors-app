import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:honors_app/modules/information/provider/management.provider.dart';
import '../../../common/values/app.colors.dart';
import '../../../common/values/app.icons.dart';
import '../../../common/widgets/basic.button.dart';
import '../../workspace/widget/text.input.dart';
import 'area.user.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key, required this.model});
  final ManagementProvider model;

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  List<String> users = [];
  @override
  Widget build(BuildContext context) {
    TextEditingController memberCtl = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: const Text('Thêm thành viên'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                TextInput(
                  controller: memberCtl,
                  width: width,
                  label: 'VD: example@gmail.com',
                ),
                InkWell(
                  onTap: () {
                    addMember(memberCtl.text);
                    memberCtl.clear();
                  },
                  child: Image.asset(
                    AppIcon.addMember,
                    width: 50,
                    height: 50,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            AreaUserWidget(
              width: width,
              users: users.reversed.toList(),
              remove: (int i) {
                setState(() {
                  users.removeAt(i);
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            users.isNotEmpty
                ? BacsicButton(
                    onPressed: () {
                      widget.model.sendEmail(users);
                      setState(() {
                        users = [];
                      });

                      Flushbar(
                        message: "Đã gửi lời mời!",
                        icon: Icon(
                          Icons.info_outline,
                          size: 28.0,
                          color: Colors.blue[300],
                        ),
                        duration: const Duration(seconds: 2),
                        leftBarIndicatorColor: Colors.blue[300],
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height - 100,
                            right: 20,
                            left: 20),
                      ).show(context);
                    },
                    primary: false,
                    label: 'GỬI EMAIL',
                    width: width * 0.85)
                : Container()
          ],
        ),
      ),
    );
  }

  void addMember(String member) {
    setState(() {
      users.add(member);
    });
  }
}
