import 'package:count_provider_app/control/ordrprovider.dart';
import 'package:count_provider_app/control/product_provider.dart';
import 'package:count_provider_app/view/re%20Orderable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'control/countprovider.dart';
import 'control/fvprovider.dart';
import 'control/themachnager.dart';
import 'view/home_page.dart';
import 'view/pro_dect_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CountProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemaProvier(),
        ),
        ChangeNotifierProvider(
          create: (context) => FvProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReOdProvider(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          themeMode:
              (Provider.of<ThemaProvier>(context).themMode.isDrak == false)
                  ? ThemeMode.light
                  : ThemeMode.dark,
          home: ReOrdeable(),
        );
      },
    ),
  );
}
