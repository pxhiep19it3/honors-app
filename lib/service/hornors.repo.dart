import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class HornorsRepo {
  final CollectionReference hornorsFisebase =
      FirebaseFirestore.instance.collection('Hornors');

  Future<void> createHornors(String content, String coreValue, int score,
      String userGet, String userSet, String time, String workspaceID) async {
    hornorsFisebase.add(({
      'content': content,
      'coreValue': coreValue,
      'score': score,
      'userGet': userGet,
      'userSet': userSet,
      'workspaceID': workspaceID,
      'time': time,
      't': int.parse(
          '${time.substring(0, 4)}${time.substring(5, 7)}${time.substring(8, 10)}')
    }));
  }

  Future<List<Users>> getUser(String workspaceID) async {
    List user = [];
    List<Users> getUser = [];
    await FirebaseFirestore.instance
        .collection('Workspace')
        .where("workspaceID", isEqualTo: workspaceID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        user = doc['members'];
      }
    });
    for (int i = 0; i < user.length; i++) {
      await FirebaseFirestore.instance
          .collection('User')
          .where('email', isEqualTo: user[i])
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          getUser.add(Users(
            id: doc.id,
            displayName: doc['displayName'].toString(),
            email: doc['email'].toString(),
            photoURL: doc['photoUrl'].toString(),
          ));
        }
      });
    }
    return getUser;
  }

  Future<Users> getAdmin(String workspaceID) async {
    String? admin;
    Users getAdmin = Users();
    await FirebaseFirestore.instance
        .collection('Workspace')
        .where("workspaceID", isEqualTo: workspaceID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        admin = doc['admin'];
      }
    });
    await FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: admin)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        getAdmin = Users(
          id: doc.id,
          displayName: doc['displayName'].toString(),
          email: doc['email'].toString(),
          photoURL: doc['photoUrl'].toString(),
        );
      }
    });
    return getAdmin;
  }

  Future<void> deleteHornors(String workspaceID) async {
    await hornorsFisebase
        .where("workspaceID", isEqualTo: workspaceID)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        await hornorsFisebase.doc(doc.id).delete();
      }
    });
  }
}
