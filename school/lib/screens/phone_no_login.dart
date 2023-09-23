// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:school_vahan/components/display_dialog.dart';
// import 'package:school_vahan/screens/update_user_details.dart';
//
// import '../main.dart';
//
// final FirebaseAuth _auth = FirebaseAuth.instance;
//
// class ScaffoldSnackbar {
//   ScaffoldSnackbar(this._context);
//   final BuildContext _context;
//
//   factory ScaffoldSnackbar.of(BuildContext context) {
//     return ScaffoldSnackbar(context);
//   }
//
//   void show(String message) {
//     ScaffoldMessenger.of(_context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(
//         SnackBar(content: Text(message)),
//       );
//   }
// }
//
// class PhoneSignInSection extends StatefulWidget {
//   static String id = 'phone_sign_in';
//   const PhoneSignInSection({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => PhoneSignInSectionState();
// }
//
// class PhoneSignInSectionState extends State<PhoneSignInSection> {
//   final _phoneNumberController = TextEditingController();
//   final _smsController = TextEditingController();
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   String _message = '';
//   bool exists = false;
//   late String _verificationId;
//   ConfirmationResult? webConfirmationResult;
//   void checkIfNumberExists() async {
//     var collection =
//         await _firebaseFirestore.collection("registeredPhoneNumbers");
//     var querySnapshot = await collection.get();
//     print(querySnapshot.docs);
//     for (var queryDocumentSnapshot in querySnapshot.docs) {
//       print(queryDocumentSnapshot.data()['phone']);
//       if (_phoneNumberController.text.toString() ==
//           "${queryDocumentSnapshot.data()['phone'].toString()}") {
//         setState(() {
//           exists = true;
//         });
//         print(exists);
//       } else {
//         setState(() {
//           exists = false;
//         });
//       }
//     }
//   }
//
//   void display() {
//     DisplayDialog.displayDialog(context, "", "sdfgxcv");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("School Vahan"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               alignment: Alignment.center,
//               child: const Text(
//                 'Sign in with phone number',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//             TextFormField(
//               enabled: !exists,
//               controller: _phoneNumberController,
//               decoration: const InputDecoration(
//                 labelText: 'Phone number',
//               ),
//               validator: (String? value) {
//                 if (value!.isEmpty) {
//                   return 'Phone number';
//                 }
//                 return null;
//               },
//             ),
//             exists
//                 ? const SizedBox()
//                 : IconButton(
//                     onPressed: checkIfNumberExists,
//                     icon: const Icon(Icons.arrow_forward_ios_rounded),
//                   ),
//             exists
//                 ? Container(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     alignment: Alignment.center,
//                     child: SignInButtonBuilder(
//                       icon: Icons.contact_phone,
//                       backgroundColor: Colors.deepOrangeAccent[700]!,
//                       text: 'Verify Number',
//                       onPressed: _verifyPhoneNumber,
//                     ),
//                   )
//                 : const SizedBox(),
//             exists
//                 ? TextField(
//                     controller: _smsController,
//                     decoration:
//                         const InputDecoration(labelText: 'Verification code'),
//                   )
//                 : const SizedBox(),
//             exists
//                 ? Container(
//                     padding: const EdgeInsets.only(top: 16),
//                     alignment: Alignment.center,
//                     child: SignInButtonBuilder(
//                       icon: Icons.arrow_forward_ios_rounded,
//                       backgroundColor: Colors.deepOrangeAccent[400]!,
//                       onPressed: _signInWithPhoneNumber,
//                       text: 'Sign In',
//                     ),
//                   )
//                 : const SizedBox(),
//             Visibility(
//               visible: _message.isNotEmpty,
//               child: Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   _message,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Example code of how to verify phone number
//   Future<void> _verifyPhoneNumber() async {
//     setState(() {
//       _message = '';
//     });
//
//     PhoneVerificationCompleted verificationCompleted =
//         (PhoneAuthCredential phoneAuthCredential) async {
//       await _auth.signInWithCredential(phoneAuthCredential);
//       ScaffoldSnackbar.of(context).show(
//           'Phone number automatically verified and user signed in: $phoneAuthCredential');
//     };
//
//     PhoneVerificationFailed verificationFailed =
//         (FirebaseAuthException authException) {
//       setState(() {
//         _message =
//             'Phone number verification failed. Code: ${authException.code}. '
//             'Message: ${authException.message}';
//       });
//     };
//
//     PhoneCodeSent codeSent =
//         (String verificationId, [int? forceResendingToken]) async {
//       ScaffoldSnackbar.of(context)
//           .show('Please check your phone for the verification code.');
//
//       _verificationId = verificationId;
//     };
//
//     PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
//         (String verificationId) {
//       _verificationId = verificationId;
//     };
//
//     try {
//       await _auth.verifyPhoneNumber(
//           phoneNumber: "+91" + _phoneNumberController.text,
//           timeout: const Duration(seconds: 5),
//           verificationCompleted: verificationCompleted,
//           verificationFailed: verificationFailed,
//           codeSent: codeSent,
//           codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
//     } catch (e) {
//       ScaffoldSnackbar.of(context).show('Failed to Verify Phone Number: $e');
//     }
//   }
//
//   // Example code of how to sign in with phone.
//   Future<void> _signInWithPhoneNumber() async {
//     try {
//       final PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: _smsController.text,
//       );
//       await _auth.signInWithCredential(credential).then((userCredential) async {
//         User? user = userCredential.user;
//         Navigator.pop(context);
//         secureStorage.write(key: "phNo", value: _phoneNumberController.text);
//         if (userCredential.additionalUserInfo!.isNewUser == true) {
//           Navigator.pushNamed(context, EnterUserDetails.id);
//         } else {
//           await FirebaseFirestore.instance
//               .collection('user')
//               .doc(user?.uid)
//               .get()
//               .then((value) {
//             secureStorage.write(
//               key: 'subsEndDate',
//               value: value.get('subs_end_date').toString(),
//             );
//           });
//           Navigator.canPop(context) ? Navigator.pop(context) : null;
//         }
//       });
//     } catch (e) {
//       print(e);
//       ScaffoldSnackbar.of(context).show('Failed to sign in');
//     }
//   }
// }
