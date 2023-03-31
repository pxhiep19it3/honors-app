import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';
import 'package:honors_app/modules/workspace/provider/workspace.provider.dart';

class JobDropButton extends StatelessWidget {
  const JobDropButton({super.key, required this.width, required this.provider});
  final double? width;
  final WorkspaceProvider provider;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
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
          value: provider.career,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: AppColor.primary),
          underline: Container(
            height: 2,
            color: Colors.transparent,
          ),
          onChanged: provider.setCareer,
          items:
              provider.listCareer.map<DropdownMenuItem<String>>((String value) {
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
