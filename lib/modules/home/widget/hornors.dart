import 'package:flutter/material.dart';
import 'package:honors_app/common/widgets/basic.text.dart';
import 'package:honors_app/modules/home/widget/select.core.value.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/values/app.text.dart';

class Hornors extends StatelessWidget {
  const Hornors({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return AlertDialog(
      backgroundColor: AppColor.gray,
      title: const Center(
          child: Text(
        'Phan Xuân Hiệp',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColor.primary),
      )),
      content: SingleChildScrollView(
        child: SizedBox(
          height: 550,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppText.selectCoreValue,
              ),
              const SizedBox(
                height: 10,
              ),
              const SelectCoreValue(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                AppText.coreHornors,
              ),
              const SizedBox(
                height: 10,
              ),
              BasicText(
                  controller: controller,
                  isContent: false,
                  keyboardType: TextInputType.number),
              const SizedBox(
                height: 10,
              ),
              const Text(
                AppText.contentHornors,
              ),
              const SizedBox(
                height: 10,
              ),
              BasicText(
                controller: controller,
                isContent: true,
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Thoát'),
          child: const Text(
            'Thoát',
            style: TextStyle(color: AppColor.primary),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Vinh danh'),
          child: const Text(
            'Vinh danh',
            style: TextStyle(color: AppColor.primary),
          ),
        ),
      ],
    );
  }
}
