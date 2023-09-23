import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FCMNotifiationHlper {
  FCMNotifiationHlper._();

  static final FCMNotifiationHlper fcmNotifiationHlper =
      FCMNotifiationHlper._();

  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> getToken() async {
    String? s = await firebaseMessaging.getToken();

    print("======================================");
    print(s);
    print("======================================");
  }

 Future<void> getapi() async {
    String s = "https://fcm.googleapis.com/fcm/send";

    Map<String, String> Myherder = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAA5KKJ8NY:APA91bGtaGp5dtq4jL1IhSF9bbUHDBb1WOLrs3jvWS5btEyf8cHuZNyRGtojDILzvCp_WdaBqn-Sh3i9_L9-AK_SCeYXN60jqasv7nVFhzo7is18IsLMBrsVVx4UiKXfOyGpIm2awGp6"
    };

    Map<String, dynamic> k = {
      "to":"dGFCdKazQLaeo_Xls0riXB:APA91bFExcWnMvyskJZFvw31mE7V0fajKj0NQmADY8XS4ujy_prnIilZeL5h0isB-iR3_dz0ZqZQ3A3PDECND_yuVJJc0nCJJ0-gncXSvtrHN5caBXoc_KZLEFnemJG8JVBgAm3BALtm",
      "notification": {
        "content_available": true,
        "priority": "high",
        "title": "hello",
        "body": "My Body"
      },
      "data": {
        "priority": "high",
        "content_available": true,
        "school": "Parth",
        "age": "22"
      }
    };

    http.Response res = await http.post(
      Uri.parse(s),
      headers: Myherder,
      body: jsonEncode(k),
    );

    if (res.statusCode == 200) {
      Map mo = jsonDecode(res.body);

      if (mo['success'] == 1) {
        print("================================");
        print("FCM SEND SUCCESSFULLY....");
        print("================================");
      }
      if (mo['failure'] == 1) {
        print("================================");
        print("FCM SEND FAILED....");
        print("================================");
      }
    }
  }
}
