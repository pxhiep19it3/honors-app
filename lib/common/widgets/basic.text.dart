import 'package:flutter/material.dart';

class BasicText extends StatelessWidget {
  const BasicText(
      {super.key,
      required this.controller,
      this.enabled,
       this.label,
      required this.isContent,
      this.height});
  final TextEditingController controller;
  final String? label;
  final bool? enabled;
  final double? height;
  final bool? isContent;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: isContent! ? 10 : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return null;
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
          enabled: enabled ?? true,
          label: Text(label ?? ''),
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)))),
    );
  }
}
