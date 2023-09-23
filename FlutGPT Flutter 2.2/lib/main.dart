import 'package:chat_gpt/screens/lenguage_pages/lenguage_screen_controller.dart';
import 'package:chat_gpt/screens/login_page/login_screen.dart';
import 'package:chat_gpt/screens/splash_screen_pages/splash_screen.dart';
import 'package:chat_gpt/theme/app_theme.dart';
import 'package:chat_gpt/theme/theme_services.dart';
import 'package:chat_gpt/utils/app_keys.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt/utils/lenguage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_controller.dart';

SharedPreferences? sharedPreferences;
void main() async {
  await GetStorage.init();
  sharedPreferences =await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LanguageScreenController());
    Get.put(MainPageController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocalString(),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isLightMode == true && isDarkMode == true
          ? ThemeServices().theme
          : isDarkMode == true
              ? ThemeMode.dark
              : isLightMode == true
                  ? ThemeMode.light
                  : ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}
