import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class ProfileRepo {
   final CollectionReference userFisebase =
      FirebaseFirestore.instance.collection('User');

  Future<Users> getUser(String email) async {
    Users user = Users();
    await userFisebase.where('email', isEqualTo: email).get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        user = Users(
          id: doc.id,
          displayName: doc['displayName'].toString(),
          email: doc['email'].toString(),
          photoURL: doc['photoUrl'].toString(),
        );
      }
    });
    return user;
  }
}