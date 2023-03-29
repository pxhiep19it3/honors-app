import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';

class JobDropButton extends StatefulWidget {
  const JobDropButton({
    super.key,
    required this.width,
  });
  final double? width;
  @override
  State<JobDropButton> createState() => _JobDropButtonState();
}

class _JobDropButtonState extends State<JobDropButton> {
  String dropdownValue = '';
  List<String> list = [
    'Chọn lĩnh vực hoạt động',
    'Công nhệ thông tin',
    'Maketing',
    'Kinh doanh'
  ];
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
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: const Border(
          left: BorderSide(width: 1.0, color: AppColor.primary),
          right: BorderSide(width: 1.0, color: AppColor.primary),
          bottom: BorderSide(width: 1.0, color: AppColor.primary),
          top: BorderSide(width: 1.0, color: AppColor.primary),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          isExpanded: true,
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: AppColor.primary),
          underline: Container(
            height: 2,
            color: Colors.transparent,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
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
