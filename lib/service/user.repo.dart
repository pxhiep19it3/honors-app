import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../models/user.dart';

class UserRepo {
  final CollectionReference userFisebase =
      FirebaseFirestore.instance.collection('User');

  Future<List<Users>> getUsers() async {
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

  Future<String> getUserID(String email) async {
    String? userID;
    await userFisebase
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        userID = doc.id;
      }
    });
    return userID!;
  }

  Future<void> addUser(
      String displayName, String email, String photoUrl) async {
    userFisebase.add(({
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'token': await getToken()
    }));
  }

  Future<void> updateToken(String email) async {
    await userFisebase
        .doc(await getUserID(email))
        .update({'token': await getToken()});
  }

  Future<String> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token!;
  }
}
