import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:honors_app/models/workspace.dart';

import '../modules/workspace/provider/workspace.provider.dart';

class WorkspaceRepo {
  final CollectionReference workspaceFisebase =
      FirebaseFirestore.instance.collection('Workspace');

  Future<List<Workspace>> getWorkspace(String emailLogin) async {
    List<Workspace> getWorkspace = [];

    await workspaceFisebase
        .where("members", arrayContains: emailLogin)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        getWorkspace.add(Workspace(
            id: doc.id,
            name: doc['name'].toString(),
            address: doc['address'].toString(),
            career: doc['career'].toString(),
            admin: doc['admin'].toString(),
            members: doc['members']));
      }
    });

    await workspaceFisebase
        .where("admin", isEqualTo: emailLogin)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        getWorkspace.add(Workspace(
            id: doc.id,
            name: doc['name'].toString(),
            address: doc['address'].toString(),
            career: doc['career'].toString(),
            admin: doc['admin'].toString(),
            members: doc['members']));
      }
    });
    return getWorkspace;
  }

  Future<void> createWorkspace(String admin, WorkspaceProvider workspace,
      List<String> listMember) async {
    workspaceFisebase.add(({
      'name': workspace.nameWorkspaceCtl.text,
      'address': workspace.addressCtl.text,
      'career': workspace.career,
      'admin': admin,
      'members': listMember
    }));
  }

  Future<void> outWorkspace(String id, String emailLogin) async {
    await workspaceFisebase.doc(id).update({
      'members': FieldValue.arrayRemove([emailLogin]),
    });
  }

  Future<void> deleteWorkspace(String id) async {
    await workspaceFisebase.doc(id).delete();
  }

  Future<void> outWorkspaceAdmin(String id, String newAdmin) async {
    await workspaceFisebase.doc(id).update({
      'admin': newAdmin,
    });
  }
}
