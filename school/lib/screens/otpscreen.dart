import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:school_vahan/components/display_dialog.dart';
import 'package:school_vahan/models/user_model.dart';
import 'package:school_vahan/screens/phonelogin.dart';
import 'package:school_vahan/screens/update_user_details.dart';
import 'package:school_vahan/user_state.dart';

import '../main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ScaffoldSnackbar {
  ScaffoldSnackbar(this._context);
  final BuildContext _context;

  factory ScaffoldSnackbar.of(BuildContext context) {
    return ScaffoldSnackbar(context);
  }

  void show(String message) {
    ScaffoldMessenger.of(_context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final _phoneNumberController = TextEditingController();
  final _smsController = TextEditingController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String _message = '';
  late String _verificationId;
  ConfirmationResult? webConfirmationResult;
  bool loading = false;
  UserModel userModel = UserModel(
    schoolId: '',
    long: '',
    guardianPhNo: '',
    lat: '',
    busNumber: '',
    guardianName: '',
    address: '',
    schoolName: '',
    standard: '',
    studentName: '',
    subsEndDate: '',
  );
  void display() {
    DisplayDialog.displayDialog(context, "", "sdfgxcv");
  }

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(0, 0, 0, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(0, 0, 0, 1),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0Xffffd800),
        key: _scaffoldkey,
        appBar: AppBar(
          backgroundColor: const Color(0Xffffd800),
          title: const Text('OTP Verification'),
        ),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'Verify +91-${widget.phone}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Pinput(
                        length: 6,
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        // submittedFieldDecoration: pinPutDecoration,
                        // selectedFieldDecoration: pinPutDecoration,
                        // followingFieldDecoration: pinPutDecoration,
                        pinAnimationType: PinAnimationType.fade,
                        onCompleted: (pin) async {
                          setState(() {
                            loading = true;
                          });
                          try {
                            final PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                              verificationId: _verificationId,
                              smsCode: pin,
                            );
                            await _auth
                                .signInWithCredential(credential)
                                .then((userCredential) async {
                              User? user = userCredential.user;

                              secureStorage.write(
                                  key: "phNo",
                                  value: _phoneNumberController.text);
                              setState(() {
                                loading = false;
                              });
                              navigateToHomeScreen(user, userCredential);

                              // if (userCredential.additionalUserInfo!.isNewUser ==
                              //     true) {
                              //   // Navigator.push(
                              //   //   context,
                              //   //   MaterialPageRoute(
                              //   //     builder: (context) => EnterUserDetails(
                              //   //       phone: widget.phone,
                              //   //     ),
                              //   //   ),
                              //   // );
                              //   Navigator.pushAndRemoveUntil(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => EnterUserDetails(
                              //             phone: widget.phone, user: userModel),
                              //       ),
                              //       (route) => false);
                              // } else {
                              //   await FirebaseFirestore.instance
                              //       .collection('user')
                              //       .doc(user?.uid)
                              //       .get()
                              //       .then((value) {
                              //     secureStorage.write(
                              //       key: 'subsEndDate',
                              //       value: value.get('subs_end_date').toString(),
                              //     );
                              //   });
                              //   Navigator.pushAndRemoveUntil(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => const UserState()),
                              //       (route) => false);
                              // }
                            }).catchError((err) {
                              print('Error caught in auth ${err}');
                            });
                          } catch (e) {
                            setState(() {
                              loading = false;
                            });
                            print("Error in auth : ${e}");
                            ScaffoldSnackbar.of(context)
                                .show('Failed to sign in');
                          }
                        }
                        // {
                        //   try {
                        //     await FirebaseAuth.instance
                        //         .signInWithCredential(PhoneAuthProvider.credential(
                        //             verificationId: _verificationId, smsCode: pin))
                        //         .then((value) async {
                        //       if (value.user != null) {
                        //         Navigator.pushAndRemoveUntil(
                        //             context,
                        //             MaterialPageRoute(builder: (context) => Home()),
                        //             (route) => false);
                        //       }
                        //     });
                        //   } catch (e) {
                        //     FocusScope.of(context).unfocus();
                        //     _scaffoldkey.currentState
                        //         ?.showSnackBar(SnackBar(content: Text('invalid OTP')));
                        //   }
                        // },
                        ),
                  )
                ],
              ),
      ),
    );
  }

  Future<void> navigateToHomeScreen(
      User? user, UserCredential userCredential) async {
    if (userCredential.additionalUserInfo!.isNewUser == true) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => EnterUserDetails(
      //       phone: widget.phone,
      //     ),
      //   ),
      // );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EnterUserDetails(phone: widget.phone, user: userModel),
        ),
      );
    } else {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(user?.uid)
          .get()
          .then((value) {
        secureStorage.write(
          key: 'subsEndDate',
          value: value.get('subs_end_date').toString(),
        );
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const UserState()),
          (route) => false);
    }
  }

  Future<void> _verifyPhone() async {
    setState(() {
      _message = '';
    });

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth
          .signInWithCredential(phoneAuthCredential)
          .then((userCredential) async {
        User? user = userCredential.user;
        Navigator.pop(context);

        secureStorage.write(key: "phNo", value: _phoneNumberController.text);

        navigateToHomeScreen(user!, userCredential);
      }).catchError((err) {
        print("Error caught in auth ${err}");
      });
      ScaffoldSnackbar.of(context).show(
          'Phone number automatically verified and user signed in: $phoneAuthCredential');
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      setState(() {
        _message =
            'Phone number verification failed. Code: ${authException.code}. '
            'Message: ${authException.message}';
      });
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      // print("*************************");
      // print("The code has been sent");
      // print("*************************");
      ScaffoldSnackbar.of(context)
          .show('Please check your phone for the verification code.');

      _verificationId = verificationId;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91" + widget.phone,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      ScaffoldSnackbar.of(context).show('Failed to Verify Phone Number: $e');
    }
  }

  // _verifyPhone() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: '+1${widget.phone}',
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         await FirebaseAuth.instance
  //             .signInWithCredential(credential)
  //             .then((value) async {
  //           if (value.user != null) {
  //             Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => Home()),
  //                 (route) => false);
  //           }
  //         });
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         print(e.message);
  //       },
  //       codeSent: (String verficationID, int? resendToken) {
  //         setState(() {
  //           _verificationCode = verficationID;
  //         });
  //       },
  //       codeAutoRetrievalTimeout: (String verificationID) {
  //         setState(() {
  //           _verificationCode = verificationID;
  //         });
  //       },
  //       timeout: Duration(seconds: 120));
  // }

}
