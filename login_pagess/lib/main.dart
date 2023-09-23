import 'package:flutter/material.dart';
import 'package:login_pagess/view/pages/Login_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/":(context) => LoginPage(),  
      },
    ),
  );
}
