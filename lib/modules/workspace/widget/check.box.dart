import 'package:flutter/material.dart';

import '../../../common/values/app.colors.dart';

class CheckBox extends StatelessWidget {
  const CheckBox({super.key, required this.isCheck, required this.onpress});
  final bool isCheck;
  final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        alignment: Alignment.center,
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: const Border(
            left: BorderSide(width: 1.5, color: AppColor.primary),
            top: BorderSide(width: 1.5, color: AppColor.primary),
            bottom: BorderSide(width: 1.5, color: AppColor.primary),
            right: BorderSide(width: 1.5, color: AppColor.primary),
          ),
        ),
        child: isCheck
            ? const Icon(
                Icons.check,
                color: AppColor.primary,
              )
            : Container(),
      ),
    );
  }
}
