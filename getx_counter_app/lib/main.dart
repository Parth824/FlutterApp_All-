import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_counter_app/view/pages/homepages.dart';
import 'package:getx_counter_app/view/pages/netpage.dart';

void main() {
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      getPages: [
        GetPage(
          name: "/",
          page: () => HomePage(),
        ),
        GetPage(
          name: "/Next",
          page: () => NextPage(),
        ),
      ],
    ),
  );
}
