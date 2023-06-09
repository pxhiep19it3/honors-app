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
    final prefs = await SharedPreferences.getInstance();
    _userList = await _userRepo.getUsers();
    _user = await Authentication.signInWithGoogle();
    await prefs.setString('userLogined', _user!.displayName ?? '');
    checkUser();
    notifyListeners();
  }

  checkUser() async {
    String email = _user!.email!;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emailLogin', email);
    await prefs.setString('photoURL', _user!.photoURL ?? '');
    List<String> emailList = [];
    for (int i = 0; i < _userList.length; i++) {
      emailList.add(_userList[i].email.toString());
    }
    if (!emailList.contains(_user!.email ?? '')) {
      addUser();
    } else {
      updateToken(_user!.email ?? '');
    }
    notifyListeners();
  }

  addUser() async {
    _userRepo.addUser(
        _user?.displayName ?? '', _user?.email ?? '', _user?.photoURL ?? '');
    notifyListeners();
  }

  updateToken(String email) async {
    _userRepo.updateToken(email);
    notifyListeners();
  }
}
