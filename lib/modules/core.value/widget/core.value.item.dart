import 'package:flutter/material.dart';

class CoreValueItem extends StatelessWidget {
  const CoreValueItem({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: RichText(
            text: const TextSpan(
              text: 'Nhóm giá trị: ',
              style: TextStyle(fontSize: 20, color: Colors.pink),
              children: <TextSpan>[
                TextSpan(
                    text: 'Chủ động',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.green)),
                TextSpan(text: '\nNội dung: '),
                TextSpan(
                    text:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 2,
                        color: Colors.blue)),
              ],
            ),
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
