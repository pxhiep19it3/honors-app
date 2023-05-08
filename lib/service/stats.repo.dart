import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/hornors.dart';

class StatsRepo {
  final CollectionReference hornorsFisebase =
      FirebaseFirestore.instance.collection('Hornors');

  Future<List<Hornors>> getHornors(
      String workspaceID, int start, int end) async {
    List<Hornors> getHornors = [];
    await hornorsFisebase
        .where("workspaceID", isEqualTo: workspaceID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        getHornors.add(Hornors(
          coreValue: doc['coreValue'].toString(),
          userSet: doc['userSet'].toString(),
          userGet: doc['userGet'].toString(),
          score: int.parse(doc['score'].toString()),
          t: int.parse(
            doc['t'].toString(),
          ),
        ));
      }
    });

    return getHornors
        .where((element) => element.t! >= start && element.t! <= end)
        .toList();
  }

  Future<List<Hornors>> getHornor(
      String workspaceID, int start, int end, String coreValue) async {
    List<Hornors> getHornors = [];
    await hornorsFisebase
        .where("workspaceID", isEqualTo: workspaceID)
        .where("coreValue", isEqualTo: coreValue)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        getHornors.add(Hornors(
          userSet: doc['userSet'].toString(),
          userGet: doc['userGet'].toString(),
          score: int.parse(doc['score'].toString()),
          t: int.parse(
            doc['t'].toString(),
          ),
        ));
      }
    });

    return getHornors
        .where((element) => element.t! >= start && element.t! <= end)
        .toList();
  }
}
