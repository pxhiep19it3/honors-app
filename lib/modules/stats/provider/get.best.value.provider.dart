import 'package:flutter/material.dart';
import 'package:honors_app/models/get.best.value.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/core.value.dart';
import '../../../models/hornors.dart';
import '../../../service/stats.repo.dart';
import '../../../service/core.value.repo.dart';

class GetBestValueProvider extends ChangeNotifier {
  final CoreValueRepo _coreValueRepo = CoreValueRepo();
  final StatsRepo _bestRepo = StatsRepo();
  List<CoreValue> _listCoreValue = [];
  final List<String> _titleValue = [];
  List<String> get titleValue => _titleValue;
  List<Hornors> _getHornors = [];
  List<GetBestValue> _getBest = [];
  List<GetBestValue> get getBest => _getBest;
  List<String> _listName = [];
  List<String> _listName1 = [];

  String? _workspaceID;

  init(String range) async {
    final prefs = await SharedPreferences.getInstance();
    _workspaceID = prefs.getString('workspaceID')!;
    _listCoreValue = await _coreValueRepo.getCoreValue(_workspaceID!);
    for (int i = 0; i < _listCoreValue.length; i++) {
      _titleValue.add(_listCoreValue[i].title ?? '');
    }
    getData(range, _titleValue[0]);
    notifyListeners();
  }

  getData(String range, String coreValue) async {
    _listName = [];
    _getBest = [];
    _getHornors = await _bestRepo.getHornor(
        _workspaceID!, start(range), end(range), coreValue);
    if (_getHornors.isNotEmpty) {
      for (int i = 0; i < _getHornors.length; i++) {
        _listName.add(_getHornors[i].userGet.toString());
      }
      _listName1 = _listName.toSet().toList();
      for (int i = 0; i < _listName1.length; i++) {
        countOccurrencesUsingLoop(_listName, _listName1[i]);
      }
    }
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

  setCoreValue(String value, String range) async {
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
    _getBest.add(GetBestValue(name: element, total: count));
    return count;
  }
}
