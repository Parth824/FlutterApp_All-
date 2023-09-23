import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_vahan/screens/home_page.dart';
import 'package:school_vahan/screens/welcome_page.dart';

class UserState extends StatelessWidget {
  static String id = "user_state";
  const UserState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.hasData) {
              return const HomePage();
            } else {
              return const WelcomePage();
            }
          } else if (userSnapshot.hasError) {
            return const Center(
              child: Text("Error Occurred"),
            );
          }
          return const Center(
            child: Text("Error Occurred"),
          );
        });
  }
}
