import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:honors_app/models/core.value.dart';
import 'package:honors_app/models/user.dart';
import 'package:honors_app/service/core.value.repo.dart';
import 'package:honors_app/service/hornors.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/notification.repo.dart';
import '../../../service/user.repo.dart';

class HomeProvider extends ChangeNotifier {
  final HornorsRepo _hornorsRepo = HornorsRepo();
  final UserRepo _userRepo = UserRepo();

  List<Users> _listUser = [];
  List<Users> get listUser => _listUser;

  List<CoreValue> _listCoreValue = [];
  List<CoreValue> get listCoreValue => _listCoreValue;

  List<Users> _userTmp = [];

  final TextEditingController _searchCTL = TextEditingController();
  TextEditingController get searchCTL => _searchCTL;

  final NotificaitionRepo _notificaitionRepo = NotificaitionRepo();

  final CoreValueRepo _coreValueRepo = CoreValueRepo();

  final TextEditingController _contentHornors = TextEditingController();
  TextEditingController get contentHornors => _contentHornors;

  String? _userLogined;
  String? get userLogined => _userLogined;

  String _emailLogin = '';
  String get emailLogin => _emailLogin;

  String? _photoURL;
  String? get photoURL => _photoURL;

  int? _score;
  String? coreValue;

  int _count = 0;

  bool _isAdMob = false;
  bool get isAdMob => _isAdMob;
  String? _workspaceID;
  String? get workspaceID => _workspaceID;
  Users _admin = Users();

  String? _selectUser;
  String? _nameWorkspace;

  init() async {
    final prefs = await SharedPreferences.getInstance();
    _userLogined = prefs.getString('userLogined');
    _workspaceID = prefs.getString('workspaceID');
    _emailLogin = prefs.getString('emailLogin')!;
    _nameWorkspace = prefs.getString('nameWorkspace');
    _admin = await _userRepo.getAdmin(_workspaceID!);
    _userTmp = await _userRepo.getUserByWorkspaceID(_workspaceID!);
    _userTmp.add(_admin);
    _listUser = _userTmp;
    _listCoreValue = await _coreValueRepo.getCoreValue(_workspaceID!);
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

  setUserHornors(String value) {
    _selectUser = value;
    notifyListeners();
  }

  createHornors(String userGet) async {
    final prefs = await SharedPreferences.getInstance();
    String? uGet = prefs.getString('uGet');
    DateTime time = DateTime.now();
    await _hornorsRepo.createHornors(
        _contentHornors.text,
        coreValue ?? _listCoreValue[0].title!,
        _score ?? _listCoreValue[0].score!,
        userGet == '' ? _selectUser ?? _listUser[0].displayName! : userGet,
        _userLogined ?? '',
        time.toString(),
        _workspaceID ?? '');
    _contentHornors.clear();
    _count++;
    if (_count % 5 == 0) {
      _isAdMob = true;
    } else {
      _isAdMob = false;
    }
    await _notificaitionRepo.sendNotification(
        uGet!, _userLogined!, _nameWorkspace!);
    notifyListeners();
  }

  setAdMob() {
    _isAdMob = false;
    notifyListeners();
  }
}
