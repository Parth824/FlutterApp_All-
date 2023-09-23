import 'dart:async';

import 'package:chat_gpt/constant/app_assets.dart';
import 'package:chat_gpt/screens/home_pages/home_screen.dart';
import 'package:chat_gpt/screens/login_page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/app_icon.dart';
import '../../google_ads_controller.dart';
import '../../main.dart';
import '../../utils/app_keys.dart';
import '../onboarding_pages/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLogin();
    getOnBoarding();
    Future.delayed(
      const Duration(seconds: 5),
    ).then((value) => Get.offAll(isLoginScreen ? const HomeScreen(): isHomeScreen == true ? const  LoginScreen() : const OnBoardingScreen() 
        ,
        transition: Transition.rightToLeft));
  }

  bool isHomeScreen = false;
  bool isLoginScreen = false;

  getOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isHomeScreen = prefs.getBool('isHomeScreen') ?? false;
    print(' -----------> $isHomeScreen');
    setState(() {});
  }

  getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoginScreen = prefs.getBool('isLoginScreen') ?? false;
    print(' -----------> $isHomeScreen');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Center(
        child: Image.asset(AppAssets.splashScreenImage),
      ),
    );
  }
}
