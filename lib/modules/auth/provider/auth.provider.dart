
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../service/auth/auth.service.dart';

class AuthModel extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  signInWithGoogle(BuildContext context) async {
    _user = await Authentication.signInWithGoogle(context: context);
    notifyListeners();
  }
}
