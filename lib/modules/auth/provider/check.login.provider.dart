import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/workspace.dart';
import '../../../service/auth.repo.dart';
import '../../../service/user.in.workspace.repo.dart';
import '../../../service/workspace.repo.dart';

class CheckLoginProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _isInWorkspace = false;
  bool get isInWorkspace => _isInWorkspace;

  String? _emailLogin;

  List<Workspace> _listWorkspace = [];
  List<String> _workspaceIDs = [];

  String _workspaceID = '';

  User? _user;
  User? get user => _user;

  final WorkspaceRepo _workspaceRepo = WorkspaceRepo();
  final UserInWorkspaceRepo _inWorkspaceRepo = UserInWorkspaceRepo();

  init() async {
    _isSignedIn = await googleSignIn.isSignedIn();
    _isSignedIn ? getWorkspace() : null;
    notifyListeners();
  }

  getWorkspace() async {
    final prefs = await SharedPreferences.getInstance();
    _emailLogin = prefs.getString('emailLogin');
    _workspaceID = prefs.getString('workspaceID')!;
    _workspaceIDs = await _inWorkspaceRepo.getWorkspaceIDs(_emailLogin ?? '');
    _workspaceIDs.isNotEmpty
        ? _listWorkspace = await _workspaceRepo.getWorkspaces(_workspaceIDs)
        : null;
    if (!_workspaceIDs.contains(_workspaceID) && _listWorkspace.isNotEmpty) {
      await prefs.setString('nameWorkspace', _listWorkspace[0].name ?? '');
      _isInWorkspace = true;
    } else if (!_workspaceIDs.contains(_workspaceID) &&
        _listWorkspace.isEmpty) {
      _isInWorkspace = false;
    } else {
      _isInWorkspace = true;
    }
    _isSignedIn && !_isInWorkspace ? getUser() : null;
    notifyListeners();
  }

  getUser() async {
    _user = await Authentication.signInWithGoogle();
    notifyListeners();
  }
}
