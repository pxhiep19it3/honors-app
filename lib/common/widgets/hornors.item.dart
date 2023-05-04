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
            style: const TextStyle(color: Colors.black87, fontSize: 13),
            children: <TextSpan>[
              TextSpan(
                  text: isHome!
                      ? "Bạn ${hornors!.userSet} đã tặng cho "
                      : isGet!
                          ? 'Bạn đã nhận được từ '
                          : 'Bạn đã tặng cho ',
                  style: const TextStyle(
                    color: AppColor.black,
                    fontSize: 18,
                    backgroundColor: Colors.transparent,
                  )),
              TextSpan(
                  text:
                      isGet! ? hornors!.userSet ?? '' : hornors!.userGet ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    backgroundColor: Colors.transparent,
                    color: Color(0xff1B2553),
                  )),
              const TextSpan(
                  text: '',
                  style: TextStyle(
                    fontSize: 22,
                    backgroundColor: Colors.transparent,
                  )),
              TextSpan(
                  text: ' ${hornors!.score} điểm vinh danh',
                  style: const TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w600,
                      backgroundColor: Colors.transparent,
                      fontSize: 18,
                      color: Colors.pink)),
              const TextSpan(
                  text: ' - nhóm giá trị ',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.black,
                    backgroundColor: Colors.transparent,
                  )),
              TextSpan(
                  text: '${hornors!.coreValue} ',
                  style: const TextStyle(
                      backgroundColor: Colors.transparent,
                      fontSize: 18,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold)),
              const TextSpan(
                  text: ',với nội dung: ',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.black,
                    backgroundColor: Colors.transparent,
                  )),
              TextSpan(
                  text: '${hornors!.content}  ',
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
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
