import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/modules/core.value/provider/corevalue.provider.dart';

import '../../../common/values/app.text.dart';
import '../../../models/core.value.dart';

class DeleteCoreValue extends StatelessWidget {
  const DeleteCoreValue({
    super.key,
    required this.item,
    required this.model,
  });
  final CoreValue item;
  final CoreValueProvider model;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.gray,
      title: const Center(
          child: Text(
        AppText.deleteCoreValue,
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColor.primary),
      )),
      content: SizedBox(
        height: 100,
        child: Center(
            child: Text(
          item.title ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColor.primary),
        )),
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
            model.deleteCoreValue(item.id ?? '');
            Navigator.pop(context, 'Xóa');
          },
          child: const Text(
            'Xóa',
            style: TextStyle(color: AppColor.primary),
          ),
        ),
      ],
    );
  }
}
