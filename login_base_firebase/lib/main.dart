import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:login_base_firebase/helper/Notification_hlper.dart';
import 'package:login_base_firebase/view/pages/homepages.dart';
import 'package:login_base_firebase/view/pages/loginpage.dart';

import 'helper/FCMnotificationhlper.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("================================");
  print("${message.notification!.title}");
  print("${message.notification!.body}");
  print("${message.data}");
  print("================================");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("================================");
    print("${message.notification!.title}");
    print("${message.notification!.body}");
    print("${message.data}");
    print("================================");
    NotificationHlper.notificationHlper.showSimpleNotification(
        tital: message.notification!.title, body: message.notification!.body);
  });
  await FCMNotifiationHlper.fcmNotifiationHlper.getToken();
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: "Login",
      routes: {
        "/": (context) => HomePage(),
        "Login": (context) => LoginPage(),
      },
    ),
  );
}
