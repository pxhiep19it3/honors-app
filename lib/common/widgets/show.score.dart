import 'package:flutter/material.dart';

import '../values/app.colors.dart';

class ShowScore extends StatelessWidget {
  const ShowScore({super.key, this.score, this.number});
  final int? score;
  final int? number;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text:  TextSpan(
          text: '',
          style: const TextStyle(
              fontSize: 20,
              color: AppColor.secondary,
              fontWeight: FontWeight.w300),
          children: [
            TextSpan(
              text: '$score',
              style:const TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
            ),
        const    TextSpan(text: ' điểm từ '),
            TextSpan(
              text: '$number',
              style: const TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
            ),
        const    TextSpan(text: ' lượt vinh danh'),
          ]),
    );
  }
}
