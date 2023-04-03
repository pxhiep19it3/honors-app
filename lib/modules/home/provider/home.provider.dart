import 'package:flutter/material.dart';
import 'package:honors_app/models/user.dart';
import 'package:honors_app/service/hornors.repo.dart';
import '../../../models/hornors.dart';

class HomeProvider extends ChangeNotifier {
  final HornorsRepo _hornorsRepo = HornorsRepo();
  List<Hornors> _listHornors = [];
  List<Hornors> get listHornors => _listHornors;

  List<Users> _listUser = [];
  List<Users> get listUser => _listUser;

  List<Users> _userTmp = [];

  final TextEditingController _searchCTL = TextEditingController();
  TextEditingController get searchCTL => _searchCTL;

  getHornors(String nameWorkspace) async {
    _listHornors = await _hornorsRepo.getHornors(nameWorkspace);
    _userTmp = await _hornorsRepo.getUser(nameWorkspace);
    _listUser = _userTmp;
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
}
