import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:honors_app/models/core.value.dart';
import 'package:honors_app/models/user.dart';
import 'package:honors_app/service/core.value.repo.dart';
import 'package:honors_app/service/hornors.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/hornors.dart';

class HomeProvider extends ChangeNotifier {
  final HornorsRepo _hornorsRepo = HornorsRepo();
  List<Hornors>? _listHornors;
  List<Hornors>? get listHornors => _listHornors;

  List<Hornors>? _listHornorsTmp;

  List<Users> _listUser = [];
  List<Users> get listUser => _listUser;

  List<CoreValue> _listCoreValue = [];
  List<CoreValue> get listCoreValue => _listCoreValue;

  List<Users> _userTmp = [];

  final TextEditingController _searchCTL = TextEditingController();
  TextEditingController get searchCTL => _searchCTL;

  final CoreValueRepo _coreValueRepo = CoreValueRepo();

  final TextEditingController _contentHornors = TextEditingController();
  TextEditingController get contentHornors => _contentHornors;

  String? _userLogined;
  String? get userLogined => _userLogined;

  String? _emailLogin;
  String? get emailLogin => _emailLogin;

  String? _photoURL;
  String? get photoURL => _photoURL;

  int? _score;
  String? coreValue;
  String workspace = '';

  int _count = 0;

  bool _isAdMob = false;
  bool get isAdMob => _isAdMob;
  String? _workspaceID;
  Users _admin = Users();

  init(String workspaceID) async {
    final prefs = await SharedPreferences.getInstance();
    _userLogined = prefs.getString('userLogined');
    _workspaceID = workspaceID;
    _listHornorsTmp = await _hornorsRepo.getHornors(_workspaceID!);
    _listHornors = _listHornorsTmp!;
    _admin = await _hornorsRepo.getAdmin(_workspaceID!);
    _userTmp = await _hornorsRepo.getUser(_workspaceID!);
    _userLogined != _admin.displayName ? _userTmp.add(_admin) : null;
    _userTmp.removeWhere((element) => element.displayName == _userLogined);
    _listUser = _userTmp;
    _listCoreValue = await _coreValueRepo.getCoreValue(_workspaceID!);
    _listHornors!.sort((a, b) => a.time!.compareTo(b.time!));
    setUser();
    notifyListeners();
  }

  setUser() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> listTMP = [];
    for (int i = 0; i < _listUser.length; i++) {
      listTMP.add(jsonEncode(_listUser[i]));
    }
    await prefs.setString('listUser', listTMP.toString());
    notifyListeners();
  }

  onSearch(String value) {
    _listUser = _userTmp
        .where((element) => element.displayName!
            .toUpperCase()
            .contains(_searchCTL.text.toUpperCase()))
        .toList();
    notifyListeners();
  }

  setScore(int value) {
    _score = value;
    notifyListeners();
  }

  setCoreValue(String value) {
    coreValue = value;
    notifyListeners();
  }

  createHornors(String userGet) async {
    DateTime time = DateTime.now();
    await _hornorsRepo.createHornors(
        _contentHornors.text,
        coreValue ?? _listCoreValue[0].title!,
        _score ?? _listCoreValue[0].score!,
        userGet,
        _userLogined ?? '',
        time.toString(),
        _workspaceID!);
    _listHornorsTmp = await _hornorsRepo.getHornors(workspace);
    _listHornors = _listHornors;
    _contentHornors.clear();
    _count++;
    if (_count % 5 == 0) {
      _isAdMob = true;
    } else {
      _isAdMob = false;
    }
    notifyListeners();
  }

  setAdMob() {
    _isAdMob = false;
    notifyListeners();
  }
}
