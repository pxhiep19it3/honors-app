import 'package:flutter/material.dart';
import 'package:honors_app/models/user.dart';
import 'package:honors_app/service/get.hornors.repo.dart';
import 'package:honors_app/service/hornors.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/core.value.dart';
import '../../../models/hornors.dart';
import '../../../service/core.value.repo.dart';

class ProfileProvider extends ChangeNotifier {
  final HornorsRepo _hornorsRepo = HornorsRepo();
  final GetHornorsRepo _hornors = GetHornorsRepo();
  final CoreValueRepo _coreValueRepo = CoreValueRepo();
  List<Hornors> _listHornors = [];
  List<Hornors> get listHornors => _listHornors;
  List<CoreValue> _listCoreValue = [];
  List<CoreValue> get listCoreValue => _listCoreValue;
  int? _scoreHornors;
  int _score = 0;
  int get score => _score;
  String? coreValue;
  String nameWorkspace = '';
  String? _userLogined;

  final TextEditingController _contentHornors = TextEditingController();
  TextEditingController get contentHornors => _contentHornors;

  init(Users user, String workspace) async {
    List listScore = [];
    _listHornors = await _hornors.getHornors(workspace, user.displayName ?? '');
    if (_listHornors.isNotEmpty) {
      _listCoreValue = await _coreValueRepo.getCoreValue(workspace);
      for (int i = 0; i < _listHornors.length; i++) {
        listScore.add(_listHornors[i].score);
      }
      _score = listScore.reduce((a, b) => a + b);
    }
    nameWorkspace = workspace;
    _listCoreValue = await _coreValueRepo.getCoreValue(workspace);
    _listHornors.sort((a, b) => b.time!.compareTo(a.time!));
    notifyListeners();
  }

  setScore(int value) {
    _scoreHornors = value;
    notifyListeners();
  }

  setCoreValue(String value) {
    coreValue = value;
    notifyListeners();
  }

  createHornors(String userGet) async {
    final prefs = await SharedPreferences.getInstance();
    _userLogined = prefs.getString('userLogined');
    DateTime time = DateTime.now();
    await _hornorsRepo.createHornors(
        _contentHornors.text,
        coreValue ?? _listCoreValue[0].title!,
        _scoreHornors ?? _listCoreValue[0].score!,
        userGet,
        _userLogined ?? '',
        nameWorkspace,
        time.toString());
    _listHornors = await _hornors.getHornors(nameWorkspace, userGet);
    _contentHornors.clear();
    notifyListeners();
  }
}
