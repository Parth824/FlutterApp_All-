import 'package:admin_panel/view/pages/login_sreen_web.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme:
                GoogleFonts.mulishTextTheme(Theme.of(context).textTheme).apply(
              bodyColor: Colors.black,
            ),
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
              },
            ),
          ),
          home: WedScreenLayout(),
        );
      },
    ),
  );
}
