import 'package:flutter/material.dart';

import '../../../common/values/app.colors.dart';
import '../../../common/values/app.images.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.width});
  final VoidCallback? onPressed;
  final String? label;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          width: width! * 0.85,
          height: 60,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: AppColor.secondary,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImage.google),
              const SizedBox(
                width: 10,
              ),
              Text(
                label!,
                style: const TextStyle(
                    color: AppColor.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
