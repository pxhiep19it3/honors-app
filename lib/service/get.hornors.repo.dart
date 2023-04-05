import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/hornors.dart';

class GetHornorsRepo {
    final CollectionReference hornorsFisebase =
      FirebaseFirestore.instance.collection('Hornors');

  Future<List<Hornors>> getHornors(String workspace, String userGet) async {
    List<Hornors> getHornors = [];

    await hornorsFisebase
        .where("workspace", isEqualTo: workspace)
          .where("userGet", isEqualTo: userGet)
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
}