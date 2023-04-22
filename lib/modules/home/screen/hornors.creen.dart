import 'package:flutter/material.dart';
import 'package:honors_app/common/widgets/basic.button.dart';
import '../../../common/values/app.colors.dart';
import '../../../common/values/app.text.dart';
import '../../../common/widgets/basic.text.dart';
import '../../../models/core.value.dart';
import '../../../models/user.dart';
import '../widget/select.core.value.dart';
import '../widget/select.score.dart';
import '../widget/select.user.dart';

class HornorsScreen extends StatefulWidget {
  const HornorsScreen(
      {super.key,
      required this.coreValue,
      required this.setScore,
      required this.createHornors,
      required this.controller,
      required this.setCoreValue,
      required this.users,
      required this.setUser,
      required this.onBack});
  final List<CoreValue>? coreValue;
  final Function(int)? setScore;
  final TextEditingController? controller;
  final Function(String)? createHornors;
  final Function(String)? setCoreValue;
  final List<Users> users;
  final Function(String)? setUser;
  final VoidCallback onBack;

  @override
  State<HornorsScreen> createState() => _HornorsScreenState();
}

class _HornorsScreenState extends State<HornorsScreen> {
  final form = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
          if (_scrollController.hasClients) {
            final position = _scrollController.position.minScrollExtent;
            _scrollController.jumpTo(position);
          }
        },
        child: Scaffold(
            backgroundColor: AppColor.secondary,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: AppColor.primary,
              centerTitle: true,
              title: const Text('Vinh danh'),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                controller: _scrollController,
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Chọn người nhận',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SelectUser(
                    listUser: widget.users,
                    setUser: widget.setUser!,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    AppText.selectCoreValue,
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SelectCoreValue(
                      coreValue: widget.coreValue,
                      isScreen: true,
                      setCoreValue: widget.setCoreValue!),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    AppText.coreHornors,
                    style: TextStyle(fontSize: 18),
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
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BasicText(
                    controller: widget.controller!,
                    isContent: true,
                    isDetail: true,
                    onTap: () {
                      if (_scrollController.hasClients) {
                        final position =
                            _scrollController.position.maxScrollExtent;
                        _scrollController.jumpTo(position);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BacsicButton(
                      onPressed: hornors,
                      label: 'Vinh danh',
                      width: double.infinity,
                      primary: false),
                  const SizedBox(
                    height: 350,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void hornors() {
    if (form.currentState!.validate()) {
      widget.createHornors!('');
      Navigator.pop(context);
      widget.onBack.call();
    }
  }
}
