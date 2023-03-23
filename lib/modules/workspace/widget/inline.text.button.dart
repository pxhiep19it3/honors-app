import 'package:flutter/material.dart';

class InlineTextButton extends StatelessWidget {
  const InlineTextButton(
      {super.key, required this.text, required this.function});
  final String text;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: const BoxConstraints(),
      onPressed: () {
        print('object');
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Colors.blue),
      ),
    );
  }
}
