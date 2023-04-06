import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:honors_app/service/set.hornors.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/hornors.dart';
import '../../../models/user.dart';

class SetHornorsProvider extends ChangeNotifier {
  SetHornorsRepo repo = SetHornorsRepo();

  List<Hornors> _listHornors = [];
  List<Hornors> get listHornors => _listHornors;

  String? _userLogined;
  String? get userLogined => _userLogined;

  init(String nameWorkspace) async {
    final prefs = await SharedPreferences.getInstance();
    _userLogined = prefs.getString('userLogined');
    _listHornors = await repo.getHornors(nameWorkspace, _userLogined ?? '');
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
