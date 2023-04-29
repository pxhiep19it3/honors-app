import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/hornors.dart';

class GetHornorsRepo {
  final CollectionReference hornorsFisebase =
      FirebaseFirestore.instance.collection('Hornors');

  List<Hornors> listHornors = [];

  Future<List<Hornors>> getHornors(String workspaceID, String userGet) async {
    List<Hornors> listHornors = [];
    await hornorsFisebase
        .where("workspaceID", isEqualTo: workspaceID)
        .where("userGet", isEqualTo: userGet)
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        listHornors.add(Hornors(
          id: doc.id,
          coreValue: doc['coreValue'].toString(),
          content: doc['content'].toString(),
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
    return listHornors;
  }
}
