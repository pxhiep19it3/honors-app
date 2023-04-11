import 'package:flutter/material.dart';
import 'package:honors_app/models/workspace.dart';
import 'package:honors_app/service/core.value.repo.dart';
import 'package:honors_app/service/hornors.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/workspace.repo.dart';

class ManagementProvider extends ChangeNotifier {
  final WorkspaceRepo _workspaceRepo = WorkspaceRepo();
  final CoreValueRepo _coreValueRepo = CoreValueRepo();
  final HornorsRepo _hornorsRepo = HornorsRepo();
  Workspace? _workspace;
  Workspace? get workspace => _workspace;

  TextEditingController? _nameCtl = TextEditingController();
  TextEditingController? get nameCtl => _nameCtl;

  TextEditingController? _addressCtl = TextEditingController();
  TextEditingController? get addressCtl => _addressCtl;

  TextEditingController? _careerCtl = TextEditingController();
  TextEditingController? get careerCtl => _careerCtl;

  TextEditingController? _adminCtl = TextEditingController();
  TextEditingController? get adminCtl => _adminCtl;

  String? nameWorkspace;
  String? id;

  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;

  String? emailLogin;

  init() async {
    final prefs = await SharedPreferences.getInstance();
    nameWorkspace = prefs.getString('nameWorkspace');
    _workspace = await _workspaceRepo.getWorkspace(nameWorkspace!);
    _nameCtl = TextEditingController(text: _workspace!.name);
    _addressCtl = TextEditingController(text: _workspace!.address);
    _careerCtl = TextEditingController(text: _workspace!.career);
    _adminCtl = TextEditingController(text: _workspace!.admin);
    id = _workspace!.id;
    emailLogin = prefs.getString('emailLogin');
    emailLogin == _workspace!.admin ? _isAdmin = true : _isAdmin = false;
    notifyListeners();
  }

  updateWorkspace() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nameWorkspace', nameCtl!.text);
    _coreValueRepo.setWorkspace(nameWorkspace!, nameCtl!.text);
    _workspaceRepo.updateWorkspace(
        id!, _addressCtl!.text, _careerCtl!.text, nameCtl!.text);
    _hornorsRepo.setWorkspace(nameWorkspace!, nameCtl!.text);
    init();
    notifyListeners();
  }

  deleteMember(String member) async {
    await _workspaceRepo.deleteMember(id!, member);
    _workspace!.members!.removeWhere((item) => item == member);
    notifyListeners();
  }

  deleteWorkspace(String nameWorkspace) async {
    await _workspaceRepo.deleteWorkspace(id!);
    await _coreValueRepo.deleteAllCoreValue(nameWorkspace);
    await _hornorsRepo.deleteHornors(nameWorkspace);
    notifyListeners();
  }

  transfeAdmin(String newAdmin) async {
    await _workspaceRepo.transfeAdmin(id!, newAdmin, emailLogin!);
    init();
    notifyListeners();
  }
}
