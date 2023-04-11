import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:honors_app/models/core.value.dart';

class CoreValueRepo {
  final CollectionReference coreFisebase =
      FirebaseFirestore.instance.collection('CoreValue');

  Future<List<CoreValue>> getCoreValue(String workspace) async {
    List<CoreValue> listCoreValue = [];
    await coreFisebase
        .where("workspace", isEqualTo: workspace)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        listCoreValue.add(CoreValue(
          id: doc.id,
          title: doc['title'].toString(),
          content: doc['content'].toString(),
          score: int.parse(doc['score'].toString()),
          workspace: doc['workspace'].toString(),
        ));
      }
    });
    return listCoreValue;
  }

  Future<void> createCoreValue(
      String workspace, String title, String content, int score) async {
    coreFisebase.add(({
      'workspace': workspace,
      'title': title,
      'content': content,
      'score': score,
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

  Future<void> setWorkspace(String workspaceOLD, String workspaceNEW) async {
    await coreFisebase
        .where("workspace", isEqualTo: workspaceOLD)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        await coreFisebase.doc(doc.id).update({
          'workspace': workspaceNEW,
        });
      }
    });
  }

  Future<void> deleteAllCoreValue(String nameWorkspace) async {
    await coreFisebase
        .where("workspace", isEqualTo: nameWorkspace)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        await coreFisebase.doc(doc.id).delete();
      }
    });
  }
}
