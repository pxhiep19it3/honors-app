import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../service/auth.repo.dart';
import '../../../service/user.repo.dart';

class AuthModel extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  final UserRepo _userRepo = UserRepo();
  signInWithGoogle() async {
    _user = await Authentication.signInWithGoogle();
    addUser();
    notifyListeners();
  }

  addUser() {
    _userRepo.addUser(
        _user?.displayName ?? '', _user?.email ?? '', _user?.photoURL ?? '');
    notifyListeners();
  }
}
