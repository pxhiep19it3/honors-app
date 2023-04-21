import 'package:flutter/material.dart';
import 'package:honors_app/common/widgets/basic.text.dart';
import 'package:honors_app/modules/core.value/provider/corevalue.provider.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/values/app.text.dart';

class AddCoreValue extends StatefulWidget {
  const AddCoreValue({super.key, required this.provider});
  final CoreValueProvider provider;

  @override
  State<AddCoreValue> createState() => _AddCoreValueState();
}

class _AddCoreValueState extends State<AddCoreValue> {
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: AlertDialog(
        backgroundColor: AppColor.gray,
        title: const Center(
            child: Text(
          AppText.addCoreValue,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColor.primary),
        )),
        content: SingleChildScrollView(
          child: SizedBox(
            height: 500,
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
                  controller: widget.provider.titleCtl,
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
                  controller: widget.provider.contentCtl,
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
            onPressed: () {
              if (form.currentState!.validate()) {
                widget.provider.addCoreValue();
                Navigator.pop(context, 'Thêm');
              }
            },
            child: const Text(
              'Thêm',
              style: TextStyle(color: AppColor.primary),
            ),
          ),
        ],
      ),
    );
  }
}
