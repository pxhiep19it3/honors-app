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
          score: int.parse(doc['score'].toString()),
        ));
      }
    });
    return getHornors;
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
}