import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfirstgame/pages/homepages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}
