import 'package:flutter/material.dart';
import 'package:honors_app/modules/workspace/screen/add.user.screen.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/values/app.text.dart';
import '../../../common/widgets/basic.button.dart';
import '../widget/check.box.dart';
import '../widget/inline.text.button.dart';
import '../widget/text.input.dart';

class CreateWorkspaceScreen extends StatefulWidget {
  const CreateWorkspaceScreen({super.key});

  @override
  State<CreateWorkspaceScreen> createState() => _CreateWorkspaceScreenState();
}

class _CreateWorkspaceScreenState extends State<CreateWorkspaceScreen> {
  TextEditingController controller = TextEditingController();
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        title: const Text(AppText.titleCreateWorkspace),
        centerTitle: true,
        backgroundColor: AppColor.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                AppText.titleWorkspace,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(AppText.desWorkspace),
              const SizedBox(
                height: 40,
              ),
              TextInput(
                controller: controller,
                width: width,
                label: 'VD: Doit Solutions',
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  CheckBox(
                    isCheck: isCheck,
                    onpress: setCheck,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Đồng ý',
                    style: TextStyle(fontSize: 15, color: AppColor.black),
                  ),
                  InlineTextButton(text: ' Chính sách', function: () {}),
                  const Text(
                    ' và ',
                    style: TextStyle(fontSize: 15, color: AppColor.black),
                  ),
                  InlineTextButton(text: 'Quyền riêng tư', function: () {}),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BacsicButton(
                onPressed: () {
                  continute(context);
                },
                label: AppText.btContinute,
                width: width * 0.85,
                primary: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setCheck() {
    setState(() {
      isCheck = !isCheck;
    });
  }

  void continute(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const AddUserScreen()));
  }
}
