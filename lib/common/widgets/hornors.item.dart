import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';

class HonorsItems extends StatelessWidget {
  const HonorsItems({super.key, this.isHome = true, this.isGet = false});
  final bool? isHome;
  final bool? isGet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: isHome!
                ? 'Bạn Phan Xuân Hiệp đã tặng '
                : isGet!
                    ? 'Bạn đã nhận được từ '
                    : 'Bạn đã tặng cho ',
            style: const TextStyle(color: AppColor.black, fontSize: 20),
            children: const <TextSpan>[
              TextSpan(
                  text: ' Phan Trung Tính ',
                  style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 2,
                    wordSpacing: 2,
                    backgroundColor: Color(0xffc6d4d9),
                    color: Color(0xff25588a),
                  )),
              TextSpan(
                  text: '  ',
                  style: TextStyle(
                    fontSize: 22,
                  )),
              TextSpan(
                  text: ' 4 điểm vinh danh ',
                  style: TextStyle(
                      letterSpacing: 2,
                      wordSpacing: 2,
                      backgroundColor: AppColor.gray,
                      fontSize: 22,
                      color: Colors.pink)),
              TextSpan(
                  text: ' - nhóm giá trị ',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              TextSpan(
                  text: ' Chủ động, ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: '\nvới nội dung:  ',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              TextSpan(
                  text:
                      '\nvẫn duy trì đều đặn các buổi seminar ngày càng chuyên nghiệp và rõ nét hơn  ',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.primary,
                    letterSpacing: 2,
                    wordSpacing: 2,
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          height: 2,
          color: Colors.black,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
