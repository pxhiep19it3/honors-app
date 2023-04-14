import 'package:flutter/material.dart';
import 'package:honors_app/models/value.best.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/hornors.dart';
import '../../../service/value.best.repo.dart';

class ValueBestProvider extends ChangeNotifier {
  final ValueBestRepo _bestRepo = ValueBestRepo();
  List<String> listTitle = [];
  List<Hornors> getHornors = [];
  final List<ValueBest> _valueBest = [];
  List<ValueBest> get valueBest => _valueBest;
  List<String> listTitle1 = [];

  init(String range) async {
    final prefs = await SharedPreferences.getInstance();
    String nameWorkspace = prefs.getString('nameWorkspace')!;
    getHornors =
        await _bestRepo.getHornors(nameWorkspace, start(range), end(range));
    if (getHornors.isNotEmpty) {
      for (int i = 0; i < getHornors.length; i++) {
        listTitle.add(getHornors[i].coreValue.toString());
      }
      listTitle1 = listTitle.toSet().toList();
      for (int i = 0; i < listTitle1.length; i++) {
        countOccurrencesUsingLoop(listTitle, listTitle1[i]);
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
