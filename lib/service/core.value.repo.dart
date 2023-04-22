import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:honors_app/models/core.value.dart';

class CoreValueRepo {
  final CollectionReference coreFisebase =
      FirebaseFirestore.instance.collection('CoreValue');

  Future<List<CoreValue>> getCoreValue(String workspaceID) async {
    List<CoreValue> listCoreValue = [];
    await coreFisebase
        .where("workspaceID", isEqualTo: workspaceID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        listCoreValue.add(CoreValue(
          id: doc.id,
          title: doc['title'].toString(),
          content: doc['content'].toString(),
          score: int.parse(doc['score'].toString()),
        ));
      }
    });
    return listCoreValue;
  }

  Future<void> createCoreValue(
      String title, String content, int score, String workspaceID) async {
    coreFisebase.add(({
      'title': title,
      'content': content,
      'score': score,
      'workspaceID': workspaceID
    }));
  }

  Future<void> deleteCoreValue(String id) async {
    await coreFisebase.doc(id).delete();
  }

  Future<void> update(String id, String title, String content) async {
    await coreFisebase.doc(id).update({'title': title, 'content': content});
  }

  Future<void> updateScore(int score, List<String> listID) async {
    for (int i = 0; i < listID.length; i++) {
      await coreFisebase.doc(listID[i]).update({'score': score});
    }
  }

  Future<void> deleteAllCoreValue(String workspaceID) async {
    await coreFisebase
        .where("workspaceID", isEqualTo: workspaceID)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        await coreFisebase.doc(doc.id).delete();
      }
    });
  }
}
