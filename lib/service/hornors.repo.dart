import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:honors_app/models/hornors.dart';
import '../models/user.dart';

class HornorsRepo {
  final CollectionReference hornorsFisebase =
      FirebaseFirestore.instance.collection('Hornors');

  Future<List<Hornors>> getHornors(String workspace) async {
    List<Hornors> getHornors = [];

    await hornorsFisebase
        .where("workspace", isEqualTo: workspace)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        getHornors.add(Hornors(
          id: doc.id,
          coreValue: doc['coreValue'].toString(),
          content: doc['content'].toString(),
          workspace: doc['workspace'].toString(),
          userSet: doc['userSet'].toString(),
          userGet: doc['userGet'].toString(),
          time: doc['time'].toString(),
          t: int.parse(
            doc['t'].toString(),
          ),
          score: int.parse(
            doc['score'].toString(),
          ),
        ));
      }
    });
    return getHornors;
  }

  Future<void> createHornors(String content, String coreValue, int score,
      String userGet, String userSet, String workspace, String time) async {
    hornorsFisebase.add(({
      'content': content,
      'coreValue': coreValue,
      'score': score,
      'userGet': userGet,
      'userSet': userSet,
      'workspace': workspace,
      'time': time,
      't': int.parse(
          '${time.substring(0, 4)}${time.substring(5, 7)}${time.substring(8, 10)}')
    }));
  }

  Future<List<Users>> getUser(String workspace) async {
    List user = [];
    List<Users> getUser = [];
    await FirebaseFirestore.instance
        .collection('Workspace')
        .where("name", isEqualTo: workspace)
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

  Future<Users> getAdmin(String workspace) async {
    String? admin;
    Users getAdmin = Users();
    await FirebaseFirestore.instance
        .collection('Workspace')
        .where("name", isEqualTo: workspace)
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

  Future<void> setWorkspace(String workspaceOLD, String workspaceNEW) async {
    await hornorsFisebase
        .where("workspace", isEqualTo: workspaceOLD)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        await hornorsFisebase.doc(doc.id).update({
          'workspace': workspaceNEW,
        });
      }
    });
  }

  Future<void> deleteHornors(String nameWorkspace) async {
    await hornorsFisebase
        .where("workspace", isEqualTo: nameWorkspace)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        await hornorsFisebase.doc(doc.id).delete();
      }
    });
  }
}
