import 'package:flutter/material.dart';

import '../values/app.colors.dart';

class BacsicButton extends StatelessWidget {
  const BacsicButton(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.width,
      required this.primary});
  final VoidCallback? onPressed;
  final String? label;
  final double? width;
  final bool? primary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          width: width,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: primary! ? AppColor.secondary : AppColor.primary,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              )),
          child: Text(
            label!,
            style: TextStyle(
                color: !primary! ? AppColor.secondary : AppColor.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}
