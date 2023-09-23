import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_vahan/components/display_dialog.dart';
import 'package:school_vahan/screens/otpscreen.dart';
import 'package:school_vahan/screens/welcome_page.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  static String id = "phonelogin";

  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  bool exists = false;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<bool> checkIfNumberExists() async {
    var collection =
        await _firebaseFirestore.collection("registeredPhoneNumbers");
    var querySnapshot = await collection.get();
    print(querySnapshot.docs);
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      if (_controller.text.toString() ==
          queryDocumentSnapshot.data()['phone'].toString()) {
        exists = true;
        break;
      } else {
        exists = false;
      }
    }
    return exists;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, WelcomePage.id);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0Xffffd800),
          title: const Text('School Vahan'),
          actions: [
            IconButton(
              onPressed: _launchURL,
              icon: const Icon(
                Icons.help_center_rounded,
                color: Colors.black,
              ),
            ),
          ],
        ),
        // backgroundColor: const Color(0Xffffd800),
        body: Container(
          color: const Color(0Xffffd800),
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 7.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: const Center(
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, right: 10, left: 10),
                  child: TextField(
                    decoration: const InputDecoration(
                      focusColor: Colors.black,
                      fillColor: Colors.black,
                      hoverColor: Colors.black,
                      hintText: 'Phone Number',
                      prefix: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text('+91'),
                      ),
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: _controller,
                  ),
                )
              ]),
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 20),
                child: CustomButton(
                  text: "Continue",
                  onClick: () async {
                    var bool = await checkIfNumberExists();
                    if (exists == true) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => OTPScreen(_controller.text)));
                    } else {
                      DisplayDialog.displayDialog(
                          context, "Number doesn't exist", "Please contact us");
                    }
                  },
                ),
              ),

              // TouchFeedback(
              //   // borderRadius: BorderRadius.circular(10),
              //   rippleColor: Colors.white,
              //   child: Container(
              //     color: Colors.black,
              //     width: double.infinity,
              //     child: TextButton(
              //       clipBehavior: Clip.hardEdge,
              //       onPressed: () async {
              //         var bool = await checkIfNumberExists();
              //         print(bool);
              //         if (exists == true) {
              //           Navigator.of(context).push(MaterialPageRoute(
              //               builder: (context) => OTPScreen(_controller.text)));
              //         } else {
              //           DisplayDialog.displayDialog(
              //               context, "Number doesn't exist", "Please contact us");
              //         }
              //       },
              //       child: const Text(
              //         'Continue',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 20,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL() async {
    if (!await launch("tel:+918299641462")) throw 'Could not make the call';
  }
}
