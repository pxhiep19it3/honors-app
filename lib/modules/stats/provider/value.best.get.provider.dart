import 'package:flutter/material.dart';
import 'package:honors_app/models/value.best.get.dart';
import 'package:honors_app/service/user.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';
import '../../../models/hornors.dart';
import '../../../models/user.dart';
import '../../../service/stats.repo.dart';

class ValueBestGetProvider extends ChangeNotifier {
  final StatsRepo _bestRepo = StatsRepo();
  final UserRepo _userRepo = UserRepo();
  final List<String> _name = [];
  List<String> get name => _name;
  List<Hornors> _getHornors = [];
  List<ValueBestGet> _getBest = [];
  List<ValueBestGet> get getBest => _getBest;
  List<String> _listCore = [];
  List<String> _listCore1 = [];

  List<Users> _users = [];

  Users _admin = Users();

  List<int> _count = [];
  int _total = 0;
  int get total => _total;

  String? _workspaceID;

  init(String range) async {
    final prefs = await SharedPreferences.getInstance();
    _workspaceID = prefs.getString('workspaceID')!;
    _users = await _userRepo.getUserByWorkspaceID(_workspaceID!);
    _admin = await _userRepo.getAdmin(_workspaceID!);
    _users.add(_admin);
    for (int i = 0; i < _users.length; i++) {
      _name.add(_users[i].displayName ?? '');
    }
    getData(range, _name[0]);
    notifyListeners();
  }

  getData(String range, String name) async {
    _listCore = [];
    _getBest = [];
    _count = [];
    _getHornors = await _bestRepo.coreValue(
        _workspaceID!, start(range), end(range), name);
    if (_getHornors.isNotEmpty) {
      for (int i = 0; i < _getHornors.length; i++) {
        _listCore.add(_getHornors[i].coreValue.toString());
      }
      _listCore1 = _listCore.toSet().toList();
      for (int i = 0; i < _listCore1.length; i++) {
        countOccurrencesUsingLoop(_listCore, _listCore1[i]);
      }
    }

    for (int i = 0; i < _getBest.length; i++) {
      _count.add(_getBest[i].total!);
    }
    _total = _count.sum;
    notifyListeners();
  }

  int start(String range) {
    String start = range.substring(0, 10).replaceAll(RegExp('/'), '');
    start =
        '${start.toString().substring(4, 8)}${start.toString().substring(2, 4)}${start.toString().substring(0, 2)}';
    return int.parse(start);
  }

  int end(String range) {
    String end = range.substring(13, 23).replaceAll(RegExp('/'), '');
    end =
        '${end.toString().substring(4, 8)}${end.toString().substring(2, 4)}${end.toString().substring(0, 2)}';
    return int.parse(end);
  }

  setValue(String value, String range) async {
    getData(range, value);
    notifyListeners();
  }

  int countOccurrencesUsingLoop(List<String> list, String element) {
    if (list.isEmpty) {}
    int count = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i] == element) {
        count++;
      }
    }
    _getBest.add(ValueBestGet(name: element, total: count));
    return count;
  }
}
