import 'package:flutter/material.dart';
import 'package:honors_app/common/values/app.colors.dart';

class AreaUser extends StatelessWidget {
  const AreaUser({
    super.key,
    required this.width,
    required this.users,
  });
  final double width;
  final List<String> users;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          left: BorderSide(width: 2, color: AppColor.primary),
          top: BorderSide(width: 2, color: AppColor.primary),
          bottom: BorderSide(width: 2, color: AppColor.primary),
          right: BorderSide(width: 2, color: AppColor.primary),
        ),
      ),
      child: ListView.builder(
          itemCount: users.length,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Text(
                    users[index],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(onTap: () {}, child: const Icon(Icons.remove_circle))
                ],
              ),
            );
          }),
    );
  }
}
