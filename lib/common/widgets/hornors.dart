import 'package:flutter/material.dart';
import 'package:honors_app/common/widgets/basic.text.dart';
import 'package:honors_app/models/core.value.dart';
import 'package:honors_app/modules/home/widget/select.core.value.dart';
import 'package:honors_app/modules/home/widget/select.score.dart';

import '../../modules/bottom/bottom.navigation.dart';
import '../../modules/core.value/screen/core.value.screen.dart';
import '../values/app.colors.dart';
import '../values/app.text.dart';

class Hornors extends StatefulWidget {
  const Hornors(
      {super.key,
      required this.name,
      required this.coreValue,
      required this.setScore,
      required this.setCoreValue,
      required this.controller,
      required this.createHornors,
      this.isBack});
  final String? name;
  final List<CoreValue>? coreValue;
  final Function(int)? setScore;
  final Function(String)? setCoreValue;
  final TextEditingController? controller;
  final Function(String)? createHornors;
  final bool? isBack;

  @override
  State<Hornors> createState() => _HornorsState();
}

class _HornorsState extends State<Hornors> {
  final form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return widget.coreValue!.isNotEmpty
        ? Form(
            key: form,
            child: AlertDialog(
              backgroundColor: AppColor.gray,
              title: Center(
                  child: Text(
                widget.name ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColor.primary),
              )),
              content: SingleChildScrollView(
                child: SizedBox(
                  height: 550,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppText.selectCoreValue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SelectCoreValue(
                          coreValue: widget.coreValue,
                          setCoreValue: widget.setCoreValue!),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        AppText.coreHornors,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SelectScore(
                        score: widget.coreValue![0].score!.toDouble(),
                        setScore: widget.setScore,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        AppText.contentHornors,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BasicText(
                        controller: widget.controller!,
                        isContent: true,
                      )
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Thoát'),
                  child: const Text(
                    'Thoát',
                    style: TextStyle(color: AppColor.primary),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (form.currentState!.validate()) {
                      widget.createHornors!(widget.name ?? '');
                      !widget.isBack!
                          ? Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavigation()),
                              (Route<dynamic> route) => false,
                            )
                          : Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Vinh danh',
                    style: TextStyle(color: AppColor.primary),
                  ),
                ),
              ],
            ),
          )
        : AlertDialog(
            backgroundColor: AppColor.gray,
            title: const Center(
                child: Text(
              'Nhóm của bạn chưa có giá trị cốt lõi nào!',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColor.primary),
            )),
            content: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const CoreValueScreen(
                              isFirst: false,
                              automaticallyImplyLeading: true,
                            )));
              },
              child: const Text('THÊM NGAY'),
            ),
          );
  }
}
