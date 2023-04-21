import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/models/hornors.dart';

class HonorsItems extends StatelessWidget {
  const HonorsItems(
      {super.key,
      this.isHome = true,
      this.isGet = false,
      required this.hornors});
  final bool? isHome;
  final bool? isGet;
  final Hornors? hornors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text:
                '${hornors!.time.toString().substring(11, 16)} ${hornors!.time.toString().substring(0, 10)}\n',
            style: const TextStyle(
                color: Colors.black87,
                // backgroundColor: Colors.blue,
                fontSize: 13),
            children: <TextSpan>[
              TextSpan(
                  text: isHome!
                      ? "${hornors!.userSet} đã tặng cho "
                      : isGet!
                          ? 'Bạn đã nhận được từ '
                          : 'Bạn đã tặng cho ',
                  style: const TextStyle(
                    color: AppColor.black,
                    fontSize: 20,
                    backgroundColor: Colors.transparent,
                  )),
              TextSpan(
                  text:
                      isGet! ? hornors!.userSet ?? '' : hornors!.userGet ?? '',
                  style: const TextStyle(
                    fontSize: 22,
                    letterSpacing: 2,
                    wordSpacing: 2,
                    backgroundColor: Color(0xffc6d4d9),
                    color: Color(0xff25588a),
                  )),
              const TextSpan(
                  text: '  ',
                  style: TextStyle(
                    fontSize: 22,
                    backgroundColor: Colors.transparent,
                  )),
              TextSpan(
                  text: ' ${hornors!.score} điểm vinh danh ',
                  style: const TextStyle(
                      letterSpacing: 2,
                      wordSpacing: 2,
                      backgroundColor: AppColor.gray,
                      fontSize: 22,
                      color: Colors.pink)),
              const TextSpan(
                  text: ' - nhóm giá trị ',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.black,
                    backgroundColor: Colors.transparent,
                  )),
              TextSpan(
                  text: ' ${hornors!.coreValue}, ',
                  style: const TextStyle(
                      backgroundColor: Colors.transparent,
                      fontSize: 20,
                      color: AppColor.black,
                      fontWeight: FontWeight.bold)),
              const TextSpan(
                  text: '\nvới nội dung:  ',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.black,
                    backgroundColor: Colors.transparent,
                  )),
              TextSpan(
                  text: '\n\t\t${hornors!.content}  ',
                  style: const TextStyle(
                    fontSize: 20,
                    color: AppColor.primary,
                    letterSpacing: 2,
                    wordSpacing: 2,
                    backgroundColor: Colors.transparent,
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
      ],
    );
  }
}
