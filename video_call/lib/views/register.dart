import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:videocall_app/providers/auth_provider.dart';
import 'package:videocall_app/utils/constants/colors.dart';
import 'package:videocall_app/utils/constants/constant.dart';
import 'package:videocall_app/utils/utils.dart';
import 'package:videocall_app/views/login.dart';
import 'package:videocall_app/views/widgets/basic_ui.dart';
import 'package:videocall_app/views/widgets/button.dart';
import 'package:videocall_app/views/widgets/text_field.dart';
import 'package:async/async.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userId = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController bestFriend = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String currentValue = 'Male';

  // List of items in our dropdown menu
  var items = [
    'Male',
    'Female',
  ];

  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _authProvider.updateIsLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return BasicUiWidget(onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }, widget: Consumer<AuthProvider>(builder: (context, authProvider, child) {
      if (authProvider.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formState,
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                Constants.register,
                textAlign: TextAlign.center,
                style: GoogleFonts.viga(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                controller: userId,
                hintText: Constants.userId,
                validator: (e) {
                  if (e == '') {
                    return 'invalid value';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                controller: bestFriend,
                hintText: Constants.bestFriendName,
                validator: (e) {
                  if (e == '') {
                    return 'invalid value';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                controller: password,
                hintText: Constants.password,
                isPassword: true,
                validator: (e) {
                  if (e == '') {
                    return 'invalid value';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldWidget(
                controller: confirmPassword,
                hintText: Constants.confirmPassword,
                isPassword: true,
                validator: (e) {
                  if (e == '') {
                    return 'invalid value';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 40,
              ),
              ButtonWidget(
                  onTap: () async {
                    // showBottomSheet(context);

                    if (formState.currentState?.validate() == true) {
                      if (password.text == confirmPassword.text) {
                        String? token =
                            await FirebaseMessaging.instance.getToken();
                        authProvider.register(context: context, body: {
                          'user_id': userId.text,
                          'name': userId.text,
                          // 'name': fullName.text,
                          'gender': currentValue,
                          'best_friend_name': bestFriend.text,
                          'password': password.text,
                          'fcm_token': token,
                        });
                      } else {
                        Utils.showSnackBar(
                            context: context,
                            message: 'password does not match!');
                      }
                    }
                  },
                  title: Constants.register),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Constants.alreadyAccount,
                      style: GoogleFonts.viga(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF707070))),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: Text(
                      " ${Constants.login}",
                      style:
                          GoogleFonts.viga(fontSize: 14, color: Colors.black),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }));
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 120,
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            children: [
              Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.cancel_outlined,
                          color: AppColor.darkGrey,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    Constants.userRegistered,
                    style: GoogleFonts.viga(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
