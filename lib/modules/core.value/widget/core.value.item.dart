import 'package:flutter/material.dart';
import 'package:honors_app/models/core.value.dart';

class CoreValueItem extends StatelessWidget {
  const CoreValueItem({super.key,  required this.item});

  final CoreValue item;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Nhóm giá trị: ',
            style: const TextStyle(fontSize: 20, color: Colors.pink),
            children: <TextSpan>[
              TextSpan(
                  text: item.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.green)),
              const TextSpan(text: '\nNội dung: '),
              TextSpan(
                  text: item.content,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 2,
                      color: Colors.blue)),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 2,
          thickness: 2,
        )
      ],
    );
  }
}
