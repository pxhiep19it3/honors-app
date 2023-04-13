import 'package:flutter/material.dart';
import 'package:honors_app/service/workspace.repo.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
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

  List<String> _listMember = [];
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
    await prefs.setString('nameWorkspace', workspace.nameWorkspaceCtl.text);
    _workspaceRepo.createWorkspace(admin, workspace, listMember);
    sendEmail(workspace.nameWorkspaceCtl.text);
    notifyListeners();
  }

  getWorkspace() async {
    final prefs = await SharedPreferences.getInstance();
    _emailLogin = prefs.getString('emailLogin');
    _listWorkspace = await _workspaceRepo.getWorkspaces(_emailLogin!);
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

  sendEmail(String name) async {
    if (_listMember.isNotEmpty) {
      for (int i = 0; i < _listMember.length; i++) {
        String username = 'hiepphan197420@gmail.com';
        String password = 'vwlpdapwoknvkdxg';
        final smtpServer = gmail(username, password);
        final message = Message()
          ..from = Address(username, 'Phan Xuân Hiệp')
          ..recipients.add(_listMember[i])
          ..subject = 'Mời bạn tham gia vào $name cùng chúng tôi!'
          ..text = ''
          ..html = r""" 
                    <center><a href="https://play.google.com/store/apps/details?id=com.facebook.katana"><img height="250px" width="400px" src="https://cdn.wikimobi.vn/2018/07/cuoc-chien-cua-hai-cho-ung-dung-lon-nhat-google-play-store-appstore.jpeg"></a><center/>
                    """;
        await send(message, smtpServer);
      }
    }
    _listMember = [];
    notifyListeners();
  }
}
