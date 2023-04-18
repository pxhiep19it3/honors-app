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
  List<Hornors> _listHornors = [];
  List<Hornors> get listHornors => _listHornors;

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

  Users _admin = Users();

  init(String nameWorkspace) async {
    final prefs = await SharedPreferences.getInstance();
    _userLogined = prefs.getString('userLogined');
    _listHornors = await _hornorsRepo.getHornors(nameWorkspace);
    _admin = await _hornorsRepo.getAdmin(nameWorkspace);
    _userTmp = await _hornorsRepo.getUser(nameWorkspace);
    _userLogined != _admin.displayName ? _userTmp.add(_admin) : null;
    _userTmp.removeWhere((element) => element.displayName == _userLogined);
    _listUser = _userTmp;
    _listCoreValue = await _coreValueRepo.getCoreValue(nameWorkspace);
    workspace = nameWorkspace;
    _listHornors.sort((a, b) => b.time!.compareTo(a.time!));
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
        workspace,
        time.toString());
    _listHornors = await _hornorsRepo.getHornors(workspace);
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
