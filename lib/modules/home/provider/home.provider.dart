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

  int? _score;
  String? coreValue;
  String workspace = '';
  init(String nameWorkspace) async {
    _listHornors = await _hornorsRepo.getHornors(nameWorkspace);
    _userTmp = await _hornorsRepo.getUser(nameWorkspace);
    _listUser = _userTmp;
    _listCoreValue = await _coreValueRepo.getCoreValue(nameWorkspace);
    workspace = nameWorkspace;
    _listHornors.sort((a, b) => b.time!.compareTo(a.time!));
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
    final prefs = await SharedPreferences.getInstance();
    String userSet = prefs.getString('userLogined')!;
    DateTime time = DateTime.now();
    await _hornorsRepo.createHornors(
        _contentHornors.text,
        coreValue ?? _listCoreValue[0].title!,
        _score ?? _listCoreValue[0].score!,
        userSet,
        userGet,
        workspace,
        time.toString());
    _listHornors = await _hornorsRepo.getHornors(workspace);
    _listHornors.sort((a, b) => b.time!.compareTo(a.time!));
    _contentHornors.clear();
    notifyListeners();
  }
}
