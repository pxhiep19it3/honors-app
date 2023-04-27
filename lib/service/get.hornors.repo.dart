import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/hornors.dart';

class GetHornorsRepo {
  final CollectionReference hornorsFisebase =
      FirebaseFirestore.instance.collection('Hornors');
  DocumentSnapshot? lastDocument;
  QuerySnapshot? querySnapshot;
  bool _isMoreData = true;
  bool get isMoreData => _isMoreData;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<Hornors> listHornors = [];
  
  Future<List<Hornors>> getHornors(String workspaceID, String userGet) async {
    if (isMoreData) {
      if (lastDocument == null) {
        querySnapshot = await hornorsFisebase
            .where("workspaceID", isEqualTo: workspaceID)
            .where("userGet", isEqualTo: userGet)
            .limit(6)
            .get();
        for (var doc in querySnapshot!.docs) {
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
      } else {
        querySnapshot = await hornorsFisebase
            .where("workspaceID", isEqualTo: workspaceID)
            .where("userGet", isEqualTo: userGet)
            .limit(6)
            .startAfterDocument(querySnapshot!.docs.last)
            .get();
        for (var doc in querySnapshot!.docs) {
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
      }
      lastDocument = querySnapshot!.docs.last;
      _isLoading = false;
      if (querySnapshot!.docs.length < 6) {
        _isMoreData = false;
      }
    }
    return listHornors;
  }
}
