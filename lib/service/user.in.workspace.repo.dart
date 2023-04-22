import 'package:cloud_firestore/cloud_firestore.dart';

class UserInWorkspaceRepo {
  final CollectionReference userFisebase =
      FirebaseFirestore.instance.collection('UserInWorkspace');

  Future<List<String>> getWorkspaceIDs(String emailLogin) async {
    List<String> getWorkspaceIDs = [];
    await userFisebase
        .where('email', isEqualTo: emailLogin)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        getWorkspaceIDs = doc['workspaceIDs'].cast<String>();
      }
    });
    return getWorkspaceIDs;
  }

  Future<String> getUserInWorkspace(String email) async {
    String getUserInWorkspace = '';
    await userFisebase
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        getUserInWorkspace = doc.id;
      }
    });

    return getUserInWorkspace;
  }

  Future<void> addUserInWorkspace(
      List<String> email, String workspaceIDs) async {
    for (int i = 0; i < email.length; i++) {
      String id = await getUserInWorkspace(email[i]);
      if (id == '') {
        await userFisebase.add(({
          'email': email[i],
          'workspaceIDs': [workspaceIDs],
        }));
      } else {
        await userFisebase.doc(id).update({
          'workspaceIDs': FieldValue.arrayUnion([workspaceIDs]),
        });
      }
    }
  }

  Future<void> deleteWorkspaceID(String workspaceID, String id) async {
    await userFisebase.doc(id).update({
      'workspaceIDs': FieldValue.arrayRemove([workspaceID]),
    });
  }

  Future<void> deleteAllWorkspaceID(
      List<String> email, String workspaceID) async {
    for (int i = 0; i < email.length; i++) {
      await userFisebase
          .where("email", isEqualTo: email[i])
          .get()
          .then((QuerySnapshot querySnapshot) async {
        for (var doc in querySnapshot.docs) {
          await userFisebase.doc(doc.id).update({
            'workspaceIDs': FieldValue.arrayRemove([workspaceID]),
          });
        }
      });
    }
  }
}
