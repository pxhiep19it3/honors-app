import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/common/values/app.icons.dart';
import 'package:honors_app/common/values/app.text.dart';
import 'package:honors_app/common/widgets/basic.button.dart';
import 'package:honors_app/modules/workspace/screen/sent.email.screen.dart';
import 'package:honors_app/modules/workspace/widget/area.user.dart';

import '../widget/text.input.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key,  required this.isFirst});
    final bool isFirst;
  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController controller = TextEditingController();
  List<String> users = [];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: const Text(AppText.titleAddUser),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                TextInput(
                  controller: controller,
                  width: width,
                  label: 'VD: example@gmail.com',
                ),
                InkWell(
                  onTap: addUser,
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
            AreaUser(
              width: width,
              users: users.reversed.toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            BacsicButton(
                onPressed: () {
                  sendEmail(context);
                },
                label: AppText.btSendEmail,
                width: width,
                primary: false)
          ],
        ),
      ),
    );
  }

  void addUser() {
    setState(() {
      users.add(controller.text);
      controller.clear();
    });
  }

  void sendEmail(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => SentEmailScreen(
                  users: users,
                  isFirst: widget.isFirst,
                )));
  }
}
