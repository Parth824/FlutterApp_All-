import 'dart:async';
import 'package:flutter/material.dart';
import 'package:videocall_app/utils/router/router_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, RoutePath.login));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF101698),
            Color(0xFF181B6D),
          ],
        )),
        child: Center(
          child: Image.asset(
            "assets/images/splash_logo.png",
            width: 142,
            height: 142,
          ),
        ),
      ),
    );
  }
}
