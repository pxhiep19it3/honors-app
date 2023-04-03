import 'package:flutter/material.dart';

import '../../../common/values/app.colors.dart';
import '../../../models/core.value.dart';

class SelectCoreValue extends StatefulWidget {
  const SelectCoreValue(
      {super.key, required this.coreValue, required this.setCoreValue});
  final List<CoreValue>? coreValue;
  final Function(String) setCoreValue;
  @override
  State<SelectCoreValue> createState() => _SelectCoreValueState();
}

class _SelectCoreValueState extends State<SelectCoreValue> {
  List<String> list = <String>[];
  String dropdownValue = '';
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.coreValue!.length; i++) {
      setState(() {
        list.add(widget.coreValue![i].content ?? '');
      });
    }
    setState(() {
      dropdownValue = list[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.secondary, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          isExpanded: true,
          value: dropdownValue,
          underline: Container(
            height: 0,
          ),
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          elevation: 16,
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
            });
            widget.setCoreValue(value!);
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
