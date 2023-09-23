import 'package:flutter/material.dart';
import 'package:login_page/view/pages/Homa_page.dart';
import 'package:login_page/view/pages/login_pages.dart';
import 'package:login_page/view/pages/restion_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences spft = await SharedPreferences.getInstance();
  List<String>? l = spft.getStringList("Loginn");
  bool? k = spft.getBool("t")?? false;

  runApp(
    MaterialApp(
      initialRoute: (l == null)? '/':(k == false)?'r':'h',
      routes: {
        '/':(context) => LoginPage(),
        'r':(context) => restiomPage(),
        'h':(context) => HomePage(),
      },
    ),
  );
}
