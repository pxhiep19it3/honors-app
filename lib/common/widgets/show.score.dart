import 'package:flutter/material.dart';

import '../values/app.colors.dart';

class ShowScore extends StatelessWidget {
  const ShowScore({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
          text: '',
          style: TextStyle(
              fontSize: 20,
              color: AppColor.secondary,
              fontWeight: FontWeight.w300),
          children: [
            TextSpan(
              text: '100',
              style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: ' điểm từ '),
            TextSpan(
              text: '10',
              style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: ' bạn vinh danh'),
          ]),
    );
  }
}
