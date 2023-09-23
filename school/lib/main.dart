import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:school_vahan/helpers/notification.dart';
import 'package:school_vahan/screens/home_page.dart';
import 'package:school_vahan/screens/payments_screen.dart';
import 'package:school_vahan/screens/phonelogin.dart';
import 'package:school_vahan/screens/welcome_page.dart';
import 'package:school_vahan/user_state.dart';
import 'models/location_notification.dart';

FlutterSecureStorage secureStorage = const FlutterSecureStorage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationHelper.notification.initializeNotification();
  await NotificationHelper.notification.fetchToken();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    final k = message.notification;
    NotificationHelper.notification.simpleNotification(
        title: k!.title.toString(), body: k!.body.toString());
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                  'Error Occurred',
                ),
              ),
            ),
          );
        }
        return MaterialApp(
          title: 'School Vahan',
          theme: ThemeData(
            primarySwatch: Colors.yellow,
          ),
          home: HomePage(),
          routes: {
            HomePage.id: (context) => const HomePage(),
            UserState.id: (context) => const UserState(),
            LoginScreen.id: (context) => const LoginScreen(),
            // PhoneSignInSection.id: (context) => const PhoneSignInSection(),
            PaymentsScreen.id: (context) => const PaymentsScreen(),
            WelcomePage.id: (context) => const WelcomePage()
          },
        );
      },
    );
  }
}
