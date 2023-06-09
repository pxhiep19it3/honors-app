import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    this.label,
    this.onChange
  });
  final TextEditingController controller;
  final String? label;
  final Function(String)? onChange;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      controller: controller,
      decoration: InputDecoration(
          fillColor: AppColor.gray,
          hintText: label,
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
