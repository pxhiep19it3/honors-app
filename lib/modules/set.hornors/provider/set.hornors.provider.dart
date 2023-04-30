import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/user.dart';

class SetHornorsProvider extends ChangeNotifier {
  String? _userLogined;
  String? get userLogined => _userLogined;

  String? _workspaceID;
  String? get workspaceID => _workspaceID;

  init() async {
    final prefs = await SharedPreferences.getInstance();
    _userLogined = prefs.getString('userLogined');
    _workspaceID = prefs.getString('workspaceID');
    notifyListeners();
  }

  Future<Users> getUser(String userGet) async {
    final prefs = await SharedPreferences.getInstance();
    String? list = prefs.getString('listUser');
    List<dynamic> body = jsonDecode(list!);
    List<Users> listUser = body.map((e) => Users.fromJson(e)).toList();
    List<Users> tmp = listUser
        .where((element) => element.displayName!.contains(userGet))
        .toList();
    notifyListeners();
    return tmp[0];
  }
}
