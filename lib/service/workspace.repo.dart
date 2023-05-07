import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:honors_app/models/workspace.dart';

import '../modules/workspace/provider/workspace.provider.dart';

class WorkspaceRepo {
  final CollectionReference workspaceFisebase =
      FirebaseFirestore.instance.collection('Workspace');

  Future<List<Workspace>> getWorkspaces(List<String> workspaceIDs) async {
    List<Workspace> getWorkspace = [];
    for (int i = 0; i < workspaceIDs.length; i++) {
      await workspaceFisebase
          .where('workspaceID', isEqualTo: workspaceIDs[i])
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          getWorkspace.add(Workspace(
              id: doc.id,
              name: doc['name'].toString(),
              admin: doc['admin'].toString(),
              workspaceID: doc['workspaceID'].toString(),
              members: doc['members']));
        }
      });
    }
    return getWorkspace;
  }

  Future<Workspace> getWorkspace(String workspaceID) async {
    Workspace getWorkspace = Workspace();
    await workspaceFisebase
        .where("workspaceID", isEqualTo: workspaceID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        getWorkspace = Workspace(
            id: doc.id,
            name: doc['name'].toString(),
            address: doc['address'].toString(),
            career: doc['career'].toString(),
            admin: doc['admin'].toString(),
            workspaceID: doc['workspaceID'].toString(),
            revenue: doc['revenue'].toString(),
            numberPhone: doc['numberPhone'].toString(),
            numberStaff: doc['numberStaff'].toString(),
            courseJoined: doc['courseJoined'].toString(),
            members: doc['members']);
      }
    });
    return getWorkspace;
  }

  Future<String> createWorkspace(String admin, WorkspaceProvider workspace,
      List<String> listMember) async {
    DocumentReference docRef = await workspaceFisebase.add(({
      'name': workspace.nameWorkspaceCtl.text,
      'address': workspace.addressCtl.text,
      'career': workspace.career,
      'admin': admin,
      'members': listMember,
      'workspaceID': '',
      'revenue':
          workspace.revenueCtl.text.isNotEmpty ? workspace.revenueCtl.text : '',
      'numberPhone':
          workspace.phoneCtl.text,
      'numberStaff': workspace.numberStaffCtl.text.isNotEmpty
          ? workspace.numberStaffCtl.text
          : '',
      'courseJoined': workspace.courseJoinedCtl.text.isNotEmpty
          ? workspace.courseJoinedCtl.text
          : ''
    }));
    await workspaceFisebase.doc(docRef.id).update({'workspaceID': docRef.id});
    return docRef.id;
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
      'members': FieldValue.arrayRemove([newAdmin]),
    });
  }

  Future<void> deleteMember(String id, String member) async {
    await workspaceFisebase.doc(id).update({
      'members': FieldValue.arrayRemove([member]),
    });
  }

  Future<void> updateWorkspace(
    String id,
    String address,
    String career,
    String name,
    String numberPhone,
    String numberStaff,
    String revenue,
    String courseJoined,
  ) async {
    await workspaceFisebase.doc(id).update({
      'address': address,
      'career': career,
      'name': name,
      'numberPhone': numberPhone,
      'numberStaff': numberStaff,
      'revenue': revenue,
      'courseJoined': courseJoined,
    });
  }

  Future<void> transfeAdmin(String id, String newAdmin, String oldAdmin) async {
    await workspaceFisebase.doc(id).update({
      'admin': newAdmin,
      'members': FieldValue.arrayRemove([newAdmin]),
    });
    await workspaceFisebase.doc(id).update({
      'members': FieldValue.arrayUnion([oldAdmin]),
    });
  }

  Future<void> addUser(String id, List user) async {
    for (int i = 0; i < user.length; i++) {
      await workspaceFisebase.doc(id).update({
        'members': FieldValue.arrayUnion([user[i]]),
      });
    }
  }
}
