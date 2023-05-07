import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/values/app.text.dart';
import '../../../common/widgets/basic.button.dart';
import '../../information/screen/policy.screen.dart';
import '../../information/screen/privacy.screen.dart';
import '../provider/workspace.provider.dart';
import '../widget/check.box.dart';
import '../widget/inline.text.button.dart';
import '../widget/text.input.dart';
import 'add.user.screen.dart';

class OtherInformationScreen extends StatefulWidget {
  const OtherInformationScreen({
    super.key,
    required this.admin,
    required this.model,
  });
  final String admin;
  final WorkspaceProvider model;

  @override
  State<OtherInformationScreen> createState() => _OtherInformationScreenState();
}

class _OtherInformationScreenState extends State<OtherInformationScreen> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        title: const Text('Tạo workspace'),
        centerTitle: true,
        backgroundColor: AppColor.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Thông tin khác',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 30,
              ),
              TextInput(
                controller: widget.model.numberStaffCtl,
                width: width,
                label: 'Số nhân viên (optional)',
              ),
              const SizedBox(
                height: 30,
              ),
              TextInput(
                controller: widget.model.revenueCtl,
                width: width,
                label: 'Doanh thu (optional)',
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Ban đã tham gia khoá học nào về xây dựng doanh nghiệp phát triển bên vững?',
                style: TextStyle(
                    color: AppColor.primary, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              TextInput(
                controller: widget.model.courseJoinedCtl,
                width: width,
                label: 'Khoá học (optional)',
              ),
              const SizedBox(
                height: 20,
              ),
              agree(),
              const SizedBox(
                height: 20,
              ),
              BacsicButton(
                onPressed: () {
                  if (isCheck) {
                    continute();
                  } else {
                    showErro();
                  }
                },
                label: AppText.btContinute,
                width: width,
                primary: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget agree() {
    return Row(
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
        InlineTextButton(
            text: ' Chính sách',
            function: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PolicyScreen()));
            }),
        const Text(
          ' và ',
          style: TextStyle(fontSize: 15, color: AppColor.black),
        ),
        InlineTextButton(
            text: 'Quyền riêng tư',
            function: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PrivacyScreen()));
            }),
      ],
    );
  }

  void showErro() {
    Flushbar(
      message: "Đồng ý chính sách và quyền riêng tư!",
      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.amber,
      ),
      duration: const Duration(seconds: 2),
      leftBarIndicatorColor: Colors.amber,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height * 0.5,
          right: 20,
          left: 20),
    ).show(context);
  }

  void setCheck() {
    setState(() {
      isCheck = !isCheck;
    });
  }

  void continute() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => AddUserScreen(
                  isFirst: true,
                  admin: widget.admin,
                  provider: widget.model,
                )));
  }
}
