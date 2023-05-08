import 'package:flutter/material.dart';
import '../../../common/values/app.colors.dart';

class SelectValue extends StatefulWidget {
  const SelectValue({
    super.key,
    required this.coreValue,
    required this.setCoreValue,
  });
  final List<String>? coreValue;
  final Function(String) setCoreValue;
  @override
  State<SelectValue> createState() => _SelectValueState();
}

class _SelectValueState extends State<SelectValue> {
  String dropdownValue = '';
  @override
  void initState() {
    super.initState();
    setState(() {
      dropdownValue = widget.coreValue![0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.gray, borderRadius: BorderRadius.circular(5)),
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
            items:
                widget.coreValue!.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
