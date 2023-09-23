import 'package:flutter/material.dart';
import 'package:sql_app_db/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3:true,
      ),
      home: HomePage(),
    ),
  );
}
