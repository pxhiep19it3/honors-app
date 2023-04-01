import 'package:flutter/material.dart';
import 'package:honors_app/service/workspace.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/workspace.dart';

class WorkspaceProvider extends ChangeNotifier {
  final TextEditingController _nameWorkspaceCtl = TextEditingController();
  TextEditingController get nameWorkspaceCtl => _nameWorkspaceCtl;
  final TextEditingController _addressCtl = TextEditingController();
  TextEditingController get addressCtl => _addressCtl;

  final WorkspaceRepo _workspaceRepo = WorkspaceRepo();

  final List<String> _listCareer = [
    'Chọn lĩnh vực hoạt động',
    'Công nhệ thông tin',
    'Maketing',
    'Kinh doanh',
    'Khác'
  ];
  List<String> get listCareer => _listCareer;
  String _career = 'Chọn lĩnh vực hoạt động';
  String get career => _career;

  final List<String> _listMember = [];
  List<String> get listMember => _listMember;

  final TextEditingController _member = TextEditingController();
  TextEditingController get member => _member;

  List<Workspace> _listWorkspace = [];
  List<Workspace> get listWorkspace => _listWorkspace;

  String? _emailLogin;
  String? get emailLogin => _emailLogin;

  setCareer(String? value) {
    if (value == 'Chọn lĩnh vực hoạt động') {
      _career = 'Khác';
    } else {
      _career = value!;
    }
    notifyListeners();
  }

  addMember() {
    listMember.add(_member.text);
    _member.clear();
    notifyListeners();
  }

  removeMember(int index) {
    listMember.removeAt(index);
    notifyListeners();
  }

  createWorkspace(String admin, WorkspaceProvider workspace) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('workspace', workspace.nameWorkspaceCtl.text);
    _workspaceRepo.createWorkspace(admin, workspace, listMember);
    notifyListeners();
  }

  getWorkspace() async {
    final prefs = await SharedPreferences.getInstance();
    _emailLogin = prefs.getString('emailLogin');
    _listWorkspace = await _workspaceRepo.getWorkspace(_emailLogin!);
    notifyListeners();
  }

  outWorkspace(String id, bool isAdmin, String newAdmin) async {
    _listWorkspace.removeWhere((item) => item.id == id);
    _workspaceRepo.outWorkspace(id, emailLogin!);
    isAdmin ? _workspaceRepo.outWorkspaceAdmin(id, newAdmin) : null;
    notifyListeners();
  }

  deleteWorkspace(String id) async {
    _listWorkspace.removeWhere((item) => item.id == id);
    _workspaceRepo.deleteWorkspace(id);
    notifyListeners();
  }
}
