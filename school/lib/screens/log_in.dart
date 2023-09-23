// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:school_vahan/constants.dart';
// import 'package:school_vahan/services/global_method.dart';
//
// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);
//   static const String id = 'log_in';
//   @override
//   _LoginState createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   final TextEditingController _emailIdController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool showSpinner = false;
//
//   String _emailAddress = '';
//   String _password = '';
//   bool _isLoading = false;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalMethods _globalMethods = GlobalMethods();
//
//   void _attemptLogin() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       await _auth
//           .signInWithEmailAndPassword(
//             email: _emailAddress.toLowerCase().trim(),
//             password: _password.trim(),
//           )
//           .then((value) =>
//               Navigator.canPop(context) ? Navigator.pop(context) : null);
//     } catch (error) {
//       _globalMethods.authErrorHandle(
//           error.toString().replaceRange(0, 31, ""), context);
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _emailIdController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             const SizedBox(
//               height: 48.0,
//             ),
//             TextFormField(
//               style: const TextStyle(
//                 fontSize: 18,
//               ),
//               keyboardType: TextInputType.emailAddress,
//               textAlign: TextAlign.center,
//               controller: _emailIdController,
//               decoration: kTextFieldDecoration.copyWith(
//                 hintText: 'Enter your email',
//                 labelText: "Email",
//               ),
//             ),
//             const SizedBox(
//               height: 15.0,
//             ),
//             TextFormField(
//               style: const TextStyle(
//                 fontSize: 18,
//               ),
//               obscureText: true,
//               textAlign: TextAlign.center,
//               controller: _passwordController,
//               decoration: kTextFieldDecoration.copyWith(
//                 hintText: 'Enter Your password',
//                 labelText: 'Password',
//               ),
//             ),
//             const SizedBox(
//               height: 24.0,
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
//               color: const Color(0xffA1DF84),
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : TextButton(
//                       child: const Text('Log In'),
//                       onPressed: () async {
//                         _emailAddress = _emailIdController.text;
//                         _password = _passwordController.text;
//                         bool emailValid = RegExp(
//                           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
//                         ).hasMatch(_emailAddress);
//                         if (!emailValid) {
//                           _globalMethods.showDialogg(
//                             "Invalid Email id",
//                             "Please enter correct email id",
//                             () {},
//                             context,
//                           );
//                         } else if (_emailAddress.isEmpty || _password.isEmpty) {
//                           _globalMethods.showDialogg(
//                             "Error",
//                             "Please enter Email address and password to login",
//                             () {},
//                             context,
//                           );
//                         } else {
//                           _attemptLogin();
//                         }
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
