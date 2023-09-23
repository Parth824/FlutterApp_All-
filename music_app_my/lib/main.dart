import 'package:flutter/material.dart';
import 'package:music_app_my/screens/login_screen.dart';
import 'package:music_app_my/screens/registration_screen.dart';
import 'package:music_app_my/screens/splash_screen.dart';

void main() {
  runApp(const MyMusicApp());
}

class MyMusicApp extends StatelessWidget {
  const MyMusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/back': (context) => const SplashScreen(),
      },
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
