import 'package:flutter/material.dart';
import 'package:honors_app/models/value.best.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/hornors.dart';
import '../../../service/stats.repo.dart';

class ValueBestProvider extends ChangeNotifier {
  final StatsRepo _bestRepo = StatsRepo();
  final List<String> _listTitle1 = [];
  List<Hornors> _getHornors = [];
  final List<ValueBest> _valueBest = [];
  List<ValueBest> get valueBest => _valueBest;
  List<String> _listTitle11 = [];

  init(String range) async {
    final prefs = await SharedPreferences.getInstance();
    String workspaceID = prefs.getString('workspaceID')!;
    _getHornors =
        await _bestRepo.getHornors(workspaceID, start(range), end(range));
    if (_getHornors.isNotEmpty) {
      for (int i = 0; i < _getHornors.length; i++) {
        _listTitle1.add(_getHornors[i].coreValue.toString());
      }
      _listTitle11 = _listTitle1.toSet().toList();
      for (int i = 0; i < _listTitle11.length; i++) {
        countOccurrencesUsingLoop(_listTitle1, _listTitle11[i]);
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

  int countOccurrencesUsingLoop(List<String> list, String element) {
    if (list.isEmpty) {}
    int count = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i] == element) {
        count++;
      }
    }
    _valueBest.add(ValueBest(title: element, total: count));
    return count;
  }
}
