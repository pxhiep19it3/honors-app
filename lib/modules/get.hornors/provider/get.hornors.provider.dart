import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:honors_app/service/get.hornors.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/core.value.dart';
import '../../../models/hornors.dart';
import '../../../models/user.dart';
import '../../../service/core.value.repo.dart';

class GetHornorsProvider extends ChangeNotifier {
  final GetHornorsRepo _getHornorsRepo = GetHornorsRepo();

  List<Hornors>? _listHornors;
  List<Hornors>? get listHornors => _listHornors;
  List<Hornors>? _listHornorsTmp;

  String? _userLogined;
  String? get userLogined => _userLogined;

  String? _emailLogin;
  String? get emailLogin => _emailLogin;

  String? _photoURL;
  String? get photoURL => _photoURL;

  int _score = 0;
  int get score => _score;

  List<CoreValue> _listCoreValue = [];
  List<CoreValue> get listCoreValue => _listCoreValue;

  final CoreValueRepo _coreValueRepo = CoreValueRepo();

  final TextEditingController _contentHornors = TextEditingController();
  TextEditingController get contentHornors => _contentHornors;

  String? _workspaceID;

  init() async {
    final prefs = await SharedPreferences.getInstance();
    List listScore = [];
    _userLogined = prefs.getString('userLogined');
    _emailLogin = prefs.getString('emailLogin');
    _photoURL = prefs.getString('photoURL');
    _workspaceID = prefs.getString('workspaceID');
    _listHornorsTmp =
        await _getHornorsRepo.getHornors(_workspaceID!, _userLogined ?? '');
    _listHornors = _listHornorsTmp!;
    if (_listHornors!.isNotEmpty) {
      _listCoreValue = await _coreValueRepo.getCoreValue(_workspaceID!);
      for (int i = 0; i < _listHornors!.length; i++) {
        listScore.add(_listHornors![i].score);
      }
      _score = listScore.reduce((a, b) => a + b);
    }
    _listHornors!.sort((a, b) => b.time!.compareTo(a.time!));
    notifyListeners();
  }

  Future<Users> getUser(String userSet) async {
    final prefs = await SharedPreferences.getInstance();
    String? list = prefs.getString('listUser');
    List<dynamic> body = jsonDecode(list!);
    List<Users> listUser = body.map((e) => Users.fromJson(e)).toList();
    List<Users> tmp = listUser
        .where((element) => element.displayName!.contains(userSet))
        .toList();
    notifyListeners();
    return tmp[0];
  }
}
