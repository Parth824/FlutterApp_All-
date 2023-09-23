// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:music_app_my/screens/home_screen.dart';
// import 'package:music_app_my/screens/login_screen.dart';
// import 'package:music_app_my/screens/registration_screen.dart';
// import 'package:music_app_my/screens/splash_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     GetMaterialApp(
//       // home: SplashScreen(),
//       home: (FirebaseAuth.instance.currentUser != null)
//           ? const HomeScreen()
//           : const LoginScreen(),
//       debugShowCheckedModeBanner: false,
//     ),
//   );
// }

// class MyMusicApp extends StatelessWidget {
//   const MyMusicApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/',
//       routes: {
//         '/login': (context) => const LoginScreen(),
//         '/register': (context) => const RegistrationScreen(),
//         '/back': (context) => const SplashScreen(),
//       },
//       home: const SplashScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
