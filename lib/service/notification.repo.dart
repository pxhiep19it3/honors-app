import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificaitionRepo {
  Future<void> sendNotification(String email, String body, String title) async {
    String? token;
    await FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        token = doc['token'];
      }
    });
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAwEikM7w:APA91bG5kreZAgppuDA9-eZIU83dgenyULzCaiNIX1y7MCsIPX1UBhLv84Qs_6GkkYSeJWDeb1QI3Rx0zTpdFSErzvG3MI30xgYlssvA0pjqetazr6JaX-tl95gOgGQ8snRH3r9oybFS',
          },
          body: jsonEncode(<String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': ' FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': '$body đã vinh danh cho bạn!',
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              'body': '$body đã vinh danh cho bạn!',
              "android_channel_id": "vinhdanh"
            },
            "to": token
          }));
    } catch (e) {
      if (kDebugMode) {
        print('error');
      }
    }
  }
}
