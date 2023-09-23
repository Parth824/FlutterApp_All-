import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:music_app_my/screens/home_screen.dart';
// import 'package:music_app_my/screens/login_screen.dart';
import 'package:music_app_my/screens/registration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 50), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RegistrationScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Image(
          image: AssetImage(
            'assets/images/audiophile.jpg',
          ),
          fit: BoxFit.cover,
          height: double.infinity),
    );
  }
}
