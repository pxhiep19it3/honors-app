import 'package:flutter/material.dart';
import 'package:honors_app/models/workspace.dart';
import 'package:honors_app/service/core.value.repo.dart';
import 'package:honors_app/service/hornors.repo.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/values/app.email.dart';
import '../../../service/user.in.workspace.repo.dart';
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

  final UserInWorkspaceRepo _inWorkspaceRepo = UserInWorkspaceRepo();

  String? nameWorkspace;

  String? workspaceID;

  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;

  String? emailLogin;

  init() async {
    final prefs = await SharedPreferences.getInstance();
    nameWorkspace = prefs.getString('nameWorkspace');
    workspaceID = prefs.getString('workspaceID');
    _workspace = await _workspaceRepo.getWorkspace(workspaceID!);
    _nameCtl = TextEditingController(text: _workspace!.name);
    _addressCtl = TextEditingController(text: _workspace!.address);
    _careerCtl = TextEditingController(text: _workspace!.career);
    _adminCtl = TextEditingController(text: _workspace!.admin);
    emailLogin = prefs.getString('emailLogin');
    emailLogin == _workspace!.admin ? _isAdmin = true : _isAdmin = false;
    notifyListeners();
  }

  updateWorkspace() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nameWorkspace', nameCtl!.text);
    _workspaceRepo.updateWorkspace(
        workspaceID!, _addressCtl!.text, _careerCtl!.text, nameCtl!.text);
    init();
    notifyListeners();
  }

  deleteMember(String member) async {
    await _workspaceRepo.deleteMember(workspaceID!, member);
    _workspace!.members!.removeWhere((item) => item == member);
    await _inWorkspaceRepo.deleteAllWorkspaceID([member], workspaceID!);
    notifyListeners();
  }

  deleteWorkspace(List<String> listEmail) async {
    await _workspaceRepo.deleteWorkspace(workspaceID!);
    await _coreValueRepo.deleteAllCoreValue(workspaceID!);
    await _hornorsRepo.deleteHornors(workspaceID!);
    listEmail.add(adminCtl!.text);
    await _inWorkspaceRepo.deleteAllWorkspaceID(listEmail, workspaceID!);
    notifyListeners();
  }

  transfeAdmin(String newAdmin) async {
    await _workspaceRepo.transfeAdmin(workspaceID!, newAdmin, emailLogin!);
    init();
    notifyListeners();
  }

  getEmailContent(String memberEmail, String nameWorkspace) {
    var content = emailTemplate;
    content = content
        .replaceAll("{member_email}", memberEmail)
        .replaceAll("{company_name}", nameWorkspace)
        .replaceAll("{company_email}", emailLogin!);
    return content;
  }

  sendEmail(List<String> listMember) async {
    if (listMember.isNotEmpty) {
      for (int i = 0; i < listMember.length; i++) {
        String username = 'hiepphan197420@gmail.com';
        String password = 'vwlpdapwoknvkdxg';
        final smtpServer = gmail(username, password);
        final message = Message()
          ..from = Address(username, 'Phan Xuân Hiệp')
          ..recipients.add(listMember[i])
          ..subject =
              'LỜI MỜI THAM GIA VÀO ${nameWorkspace!.toUpperCase()} CÙNG CHÚNG TÔI!'
          ..text = ''
          ..html = getEmailContent(listMember[i], nameWorkspace!);
        await send(message, smtpServer);
      }
      await _workspaceRepo.addUser(workspaceID!, listMember);
      await _inWorkspaceRepo.addUserInWorkspace(listMember, workspaceID!);
    }
    init();
    notifyListeners();
  }
}
