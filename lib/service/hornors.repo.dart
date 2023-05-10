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
