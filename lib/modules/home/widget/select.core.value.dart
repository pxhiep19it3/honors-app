import 'package:flutter/material.dart';

import '../../../common/values/app.colors.dart';

class SelectCoreValue extends StatefulWidget {
  const SelectCoreValue({super.key});

  @override
  State<SelectCoreValue> createState() => _SelectCoreValueState();
}

class _SelectCoreValueState extends State<SelectCoreValue> {
  List<String> list = <String>[
    'Giá trị 1',
    'Giá trị 2',
    'Giá trị 3',
    'Giá trị 4'
  ];
  String dropdownValue = '';
  @override
  void initState() {
    super.initState();
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
