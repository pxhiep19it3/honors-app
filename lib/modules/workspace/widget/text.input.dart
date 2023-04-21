import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.controller,
    this.label,
    required this.width,
    this.enabled,
    this.onChange,
  });
  final TextEditingController controller;
  final String? label;
  final double? width;
  final bool? enabled;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Bạn chưa nhập vào đây!';
          }
          return null;
        },
        controller: controller,
        onChanged: onChange,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.5, color: AppColor.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.5, color: AppColor.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: label ?? '',
          labelStyle: const TextStyle(color: AppColor.primary),
          enabled: enabled ?? true,
        ),
      ),
    );
  }
}
