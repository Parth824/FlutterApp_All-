import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_vahan/screens/phonelogin.dart';
import 'package:school_vahan/services/global_method.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  static String id = 'welcome_page';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalMethods _globalMethods = GlobalMethods();

  // Future<void> _googleSignIn() async {
  //   final googleSignIn = GoogleSignIn();
  //   final googleAccount = await googleSignIn.signIn();
  //   if (googleAccount != null) {
  //     final googleAuth = await googleAccount.authentication;
  //     if (googleAuth.accessToken != null && googleAuth.idToken != null) {
  //       try {
  //         final authResult = await _auth.signInWithCredential(
  //           GoogleAuthProvider.credential(
  //             idToken: googleAuth.idToken,
  //             accessToken: googleAuth.accessToken,
  //           ),
  //         );
  //       } catch (error) {
  //         _globalMethods.authErrorHandle(error.toString(), context);
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Container(
      color: Color(0Xffffd800),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image(
                fit: BoxFit.fill,
                image: const AssetImage('images/logo.jpg'),
                width: _width / 1.3,
                height: _height / 2.5,
              )),

          // Container(
          //   decoration: const BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(15),
          //       topRight: Radius.circular(15),
          //     ),
          //   ),
          //   child: const Text(
          //     "School Vahan",
          //     style: TextStyle(
          //       fontSize: 36,
          //       fontFamily: "Brand-Bold",
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: _height / 5,
          ),
          CustomButton(
            text: "Log in",
            onClick: () {
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
          ),
          SizedBox(
            height: _height / 20,
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Function() onClick;
  final String text;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        minimumSize: Size(
          MediaQuery.of(context).size.width * 0.8,
          2,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 60,
          vertical: 10,
        ),
        textStyle: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onClick,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
