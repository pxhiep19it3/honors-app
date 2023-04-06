import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/hornors.dart';
import '../models/user.dart';

class SetHornorsRepo {
    final CollectionReference hornorsFisebase =
      FirebaseFirestore.instance.collection('Hornors');

  Future<List<Hornors>> getHornors(String workspace, String userSet) async {
    List<Hornors> getHornors = [];

    await hornorsFisebase
        .where("workspace", isEqualTo: workspace)
          .where("userSet", isEqualTo: userSet)
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
          score: int.parse(
            doc['score'].toString(),
          ),
        ));
      }
    });
    return getHornors;
  }

    Future<Users> getUser(String workspace, String name) async {
    Users getUser = Users();
    
    await FirebaseFirestore.instance
        .collection('Workspace')
        .where("name", isEqualTo: workspace)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
      
      }
    });
    await FirebaseFirestore.instance
        .collection('User')
        .where('displayName', isEqualTo: name)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
     getUser =   Users(
          id: doc.id,
          displayName: doc['displayName'].toString(),
          email: doc['email'].toString(),
          photoURL: doc['photoUrl'].toString(),
        );
      }
    });
    return getUser;
  }
}