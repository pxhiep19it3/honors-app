import 'package:flutter/material.dart';
import 'package:honors_app/service/set.hornors.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/core.value.dart';
import '../../../models/hornors.dart';
import '../../../service/core.value.repo.dart';
import '../../../service/hornors.repo.dart';

class GetHornorsProvider extends ChangeNotifier {
  final SetHornorsRepo _setHornorsRepo = SetHornorsRepo();
  List<Hornors> _listHornors = [];

  List<Hornors> get listHornors => _listHornors;

  String? _userLogined;
  String? get userLogined => _userLogined;

  String? _emailLogin;
  String? get emailLogin => _emailLogin;

  String? _photoURL;
  String? get photoURL => _photoURL;

  int _score = 0;
  int get score => _score;

  int? _scoreHornors;

  List<CoreValue> _listCoreValue = [];
  List<CoreValue> get listCoreValue => _listCoreValue;

  final CoreValueRepo _coreValueRepo = CoreValueRepo();

  final HornorsRepo _hornorsRepo = HornorsRepo();

    final TextEditingController _contentHornors = TextEditingController();
  TextEditingController get contentHornors => _contentHornors;

  String? coreValue;
  String workspace = '';

  getSetHornors(String nameWorkspace) async {
    final prefs = await SharedPreferences.getInstance();
    List listScore = [];
    workspace = nameWorkspace;
    _userLogined = prefs.getString('userLogined');
    _emailLogin = prefs.getString('emailLogin');
    _photoURL = prefs.getString('photoURL');
    _listHornors =
        await _setHornorsRepo.getHornors(nameWorkspace, _userLogined ?? '');
            _listCoreValue = await _coreValueRepo.getCoreValue(nameWorkspace);
    for (int i = 0; i < _listHornors.length; i++) {
      listScore.add(_listHornors[i].score);
    }
    _score = listScore.reduce((a, b) => a + b);
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
    DateTime time = DateTime.now();
    await _hornorsRepo.createHornors(
        _contentHornors.text,
        coreValue ?? _listCoreValue[0].title!,
        _scoreHornors ?? _listCoreValue[0].score!,
        _userLogined ?? '',
        userGet,
        workspace,
        time.toString());
    _listHornors = await _setHornorsRepo.getHornors(workspace, _userLogined ??'');
    _listHornors.sort((a, b) => b.time!.compareTo(a.time!));
    _contentHornors.clear();
    notifyListeners();
  }
}
