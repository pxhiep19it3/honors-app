import 'package:flutter/material.dart';
import 'package:honors_app/models/core.value.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/core.value.repo.dart';

class CoreValueProvider extends ChangeNotifier {
  final CoreValueRepo _coreValueRepo = CoreValueRepo();

  List<CoreValue> _listCore = [];
  List<CoreValue> get listCore => _listCore;
  String? workspace;

  TextEditingController _titleCtl = TextEditingController();
  TextEditingController get titleCtl => _titleCtl;

  TextEditingController _contentCtl = TextEditingController();
  TextEditingController get contentCtl => _contentCtl;

  final int _score = 10;
  int get score => _score;

  getCoreValue() async {
    _listCore = [];
    final prefs = await SharedPreferences.getInstance();
    workspace = prefs.getString('workspace');
    _listCore = await _coreValueRepo.getCoreValue(workspace!);
    notifyListeners();
  }

  addCoreValue() async {
    await _coreValueRepo.createCoreValue(
        workspace!, _titleCtl.text, _contentCtl.text, _score);
    getCoreValue();
    clearCtl();
    notifyListeners();
  }

  clearCtl() {
    _contentCtl.clear();
    _titleCtl.clear();
    notifyListeners();
  }

  deleteCoreValue(String id) async {
    _listCore.removeWhere((element) => element.id == id);
    await _coreValueRepo.deleteCoreValue(id);
    clearCtl();
    notifyListeners();
  }

  setValueOnTap(String title, String content) {
    _titleCtl = TextEditingController(text: title);
    _contentCtl = TextEditingController(text: content);
    notifyListeners();
  }

  update(String id) async {
    await _coreValueRepo.update(id, _titleCtl.text, _contentCtl.text);
    getCoreValue();
    _listCore = _listCore.reversed.toList();
    notifyListeners();
  }

  List<String> getListID() {
    List<String> listID = [];
    for (int i = 0; i < _listCore.length; i++) {
      listID.add(_listCore[i].id ?? '');
    }
    notifyListeners();
    return listID;
  }

  updateScore(int score) async {
    await _coreValueRepo.updateScore(score, getListID());
    getCoreValue();
    notifyListeners();
  }
}
