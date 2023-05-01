import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/values/app.colors.dart';
import '../../../models/user.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({
    super.key,
    required this.listUser,
    required this.setUser,
  });
  final List<Users>? listUser;
  final Function(String) setUser;

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  List<String> list = <String>[];
  List<String> listEmail = <String>[];
  String dropdownValue = '';
  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.listUser!.length; i++) {
      setState(() {
        list.add(widget.listUser![i].displayName ?? '');
        listEmail.add(widget.listUser![i].email ?? '');
      });
    }
    setState(() {
      dropdownValue = list[0];
    });
    setEmail();
  }

  void setEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uGet', listEmail[list.indexOf(dropdownValue)]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          onChanged: (String? value) async {
            final prefs = await SharedPreferences.getInstance();
            setState(() {
              dropdownValue = value!;
            });
            await prefs.setString(
                'uGet', listEmail[list.indexOf(dropdownValue)]);
            widget.setUser(value!);
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
