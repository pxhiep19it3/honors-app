import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user.dart';
import '../../../service/auth.repo.dart';
import '../../../service/user.repo.dart';

class AuthModel extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  final UserRepo _userRepo = UserRepo();
  List<Users> _userList = [];
  List<Users> get retrievedUsers => _userList;

  signInWithGoogle() async {
    _userList = await _userRepo.getUser();
    _user = await Authentication.signInWithGoogle();
    checkUser();
    notifyListeners();
  }

  checkUser() async {
    String email = _user!.email!;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emailLogin', email);
    List<String> emailList = [];
    for (int i = 0; i < _userList.length; i++) {
      emailList.add(_userList[i].email.toString());
    }
    if (!emailList.contains(_user!.email ?? '')) {
      addUser();
    } else {}
    notifyListeners();
  }

  addUser() {
    _userRepo.addUser(
        _user?.displayName ?? '', _user?.email ?? '', _user?.photoURL ?? '');
    notifyListeners();
  }
}
