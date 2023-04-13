import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';

class AreaUserWidget extends StatefulWidget {
  const AreaUserWidget({
    super.key,
    required this.width,
    required this.users,
    required this.remove,
  });
  final double width;
  final List<String> users;
  final Function(int) remove;

  @override
  State<AreaUserWidget> createState() => _AreaUserWidgetState();
}

class _AreaUserWidgetState extends State<AreaUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          left: BorderSide(width: 1, color: AppColor.primary),
          top: BorderSide(width: 1, color: AppColor.primary),
          bottom: BorderSide(width: 1, color: AppColor.primary),
          right: BorderSide(width: 1, color: AppColor.primary),
        ),
      ),
      child: ListView.builder(
          itemCount: widget.users.length,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Expanded(
                  child: Text(
                    widget.users[index],
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      widget.remove(index);
                    },
                    child: const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                    ))
              ],
            );
          }),
    );
  }
}
