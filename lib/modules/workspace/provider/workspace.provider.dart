import 'package:flutter/material.dart';
import 'package:honors_app/service/hornors.repo.dart';
import 'package:honors_app/service/workspace.repo.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/values/app.email.dart';
import '../../../models/workspace.dart';
import '../../../service/core.value.repo.dart';
import '../../../service/user.in.workspace.repo.dart';

class WorkspaceProvider extends ChangeNotifier {
  final TextEditingController _nameWorkspaceCtl = TextEditingController();
  TextEditingController get nameWorkspaceCtl => _nameWorkspaceCtl;
  final TextEditingController _addressCtl = TextEditingController();
  TextEditingController get addressCtl => _addressCtl;

  final WorkspaceRepo _workspaceRepo = WorkspaceRepo();
  final UserInWorkspaceRepo _inWorkspaceRepo = UserInWorkspaceRepo();
  final HornorsRepo _hornorsRepo = HornorsRepo();
  final CoreValueRepo _coreValueRepo = CoreValueRepo();

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

  List<Workspace>? _listWorkspace;
  List<Workspace>? get listWorkspace => _listWorkspace;

  List<Workspace>? _listWorkspaceTmp;

  String? _emailLogin;
  String? get emailLogin => _emailLogin;

  List<String> _workspaceIDs = [];

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
    String workspaceID = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nameWorkspace', workspace.nameWorkspaceCtl.text);
    workspaceID =
        await _workspaceRepo.createWorkspace(admin, workspace, _listMember);
    await prefs.setString('workspaceID', workspaceID);
    await _inWorkspaceRepo.addUserInWorkspace(_listMember, workspaceID);
    await _inWorkspaceRepo.addUserInWorkspace([admin], workspaceID);
    sendEmail(workspace.nameWorkspaceCtl.text);
    notifyListeners();
  }

  getWorkspace() async {
    final prefs = await SharedPreferences.getInstance();
    _emailLogin = prefs.getString('emailLogin');
    _workspaceIDs = await _inWorkspaceRepo.getWorkspaceIDs(_emailLogin ?? '');
    _listWorkspaceTmp = await _workspaceRepo.getWorkspaces(_workspaceIDs);
    _listWorkspace = _listWorkspaceTmp!;
    notifyListeners();
  }

  outWorkspace(String id, bool isAdmin, String newAdmin) async {
    _listWorkspace!.removeWhere((item) => item.id == id);
    _workspaceRepo.outWorkspace(id, emailLogin!);
    isAdmin ? _workspaceRepo.outWorkspaceAdmin(id, newAdmin) : null;
    String tmp = await _inWorkspaceRepo.getUserInWorkspace(_emailLogin!);
    await _inWorkspaceRepo.deleteWorkspaceID(id, tmp);
    notifyListeners();
  }

  deleteWorkspace(String id, List<String> listEmail, String admin,
      bool notifyListener) async {
    _listWorkspace!.removeWhere((item) => item.id == id);
    await _workspaceRepo.deleteWorkspace(id);
    await _hornorsRepo.deleteHornors(id);
    await _coreValueRepo.deleteAllCoreValue(id);
    listEmail.add(admin);
    await _inWorkspaceRepo.deleteAllWorkspaceID(listEmail, id);
    !notifyListener ? notifyListeners() : null;
  }

  getEmailContent(String memberEmail, String nameWorkspace, String logined) {
    var content = emailTemplate;
    content = content
        .replaceAll("{member_email}", memberEmail)
        .replaceAll("{company_name}", nameWorkspace)
        .replaceAll("{company_email}", logined);
    return content;
  }

  sendEmail(String name) async {
    final prefs = await SharedPreferences.getInstance();
    _emailLogin = prefs.getString('emailLogin');
    if (_listMember.isNotEmpty) {
      for (int i = 0; i < _listMember.length; i++) {
        String username = 'hiepphan197420@gmail.com';
        String password = 'vwlpdapwoknvkdxg';
        final smtpServer = gmail(username, password);
        final message = Message()
          ..from = Address(username, 'Phan Xuân Hiệp')
          ..recipients.add(_listMember[i])
          ..subject =
              'LỜI MỜI THAM GIA VÀO ${name.toUpperCase()} CÙNG CHÚNG TÔI!'
          ..text = ''
          ..html = getEmailContent(_listMember[i], name, _emailLogin!);
        await send(message, smtpServer);
      }
    }
    _listMember = [];
    notifyListeners();
  }
}
