import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserRepo {
  final CollectionReference userFisebase =
      FirebaseFirestore.instance.collection('User');

  Future<List<Users>> getUser() async {
    List<Users> getUser = [];
    await userFisebase.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        getUser.add(Users(
          id: doc.id,
          displayName: doc['displayName'].toString(),
          email: doc['email'].toString(),
          photoURL: doc['photoUrl'].toString(),
        ));
      }
    });
    return getUser;
  }

  Future<void> addUser(
      String displayName, String email, String photoUrl, String id) async {
    userFisebase.add(({
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'uID': id
    }));
  }
}
