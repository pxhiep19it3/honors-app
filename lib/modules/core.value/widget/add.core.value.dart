import 'package:flutter/material.dart';
import 'package:honors_app/common/widgets/basic.text.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/values/app.text.dart';

class AddCoreValue extends StatelessWidget {
  const AddCoreValue({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return AlertDialog(
      backgroundColor: AppColor.gray,
      title: const Center(
          child: Text(
        AppText.addCoreValue,
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColor.primary),
      )),
      content: SingleChildScrollView(
        child: SizedBox(
          height: 450,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppText.nameCoreValue,
              ),
              const SizedBox(
                height: 10,
              ),
              BasicText(
                controller: controller,
                isContent: false,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                AppText.contentCoreValue,
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
          onPressed: () => Navigator.pop(context, 'Thêm'),
          child: const Text(
            'Thêm',
            style: TextStyle(color: AppColor.primary),
          ),
        ),
      ],
    );
  }
}
