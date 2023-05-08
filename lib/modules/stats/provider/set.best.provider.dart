import 'package:flutter/material.dart';
import 'package:honors_app/models/set.best.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/hornors.dart';
import '../../../service/stats.repo.dart';

class SetBestProvider extends ChangeNotifier {
  final StatsRepo _bestRepo = StatsRepo();
  final List<String> _listName = [];
  List<Hornors> getHornors = [];
  final List<SetBest> _setBest = [];
  List<SetBest> get setBest => _setBest;
  List<String> _listName1 = [];

  init(String range) async {
    final prefs = await SharedPreferences.getInstance();
    String workspaceID = prefs.getString('workspaceID')!;
    getHornors =
        await _bestRepo.getHornors(workspaceID, start(range), end(range));
    if (getHornors.isNotEmpty) {
      for (int i = 0; i < getHornors.length; i++) {
        _listName.add(getHornors[i].userSet.toString());
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

  int countOccurrencesUsingLoop(List<String> list, String element) {
    if (list.isEmpty) {}
    int count = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i] == element) {
        count++;
      }
    }
    _setBest.add(SetBest(name: element, total: count));
    return count;
  }
}
