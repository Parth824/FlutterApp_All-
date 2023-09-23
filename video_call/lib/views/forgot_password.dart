import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:videocall_app/providers/auth_provider.dart';
import 'package:videocall_app/utils/constants/constant.dart';
import 'package:videocall_app/utils/utils.dart';
import 'package:videocall_app/views/widgets/basic_ui.dart';
import 'package:videocall_app/views/widgets/button.dart';
import 'package:videocall_app/views/widgets/text_field.dart';

import '../utils/constants/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController userId = TextEditingController();
  TextEditingController bestFriend = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _authProvider.updateIsLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return BasicUiWidget(
      showBackBtn: true,
      widget: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: formstate,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    Constants.forgotPassword,
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
                    controller: newPassword,
                    hintText: Constants.newPassword,
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
                      onTap: () {
                        if (formstate.currentState?.validate() == true) {
                          if (newPassword.text == confirmPassword.text) {
                            authProvider
                                .forgetPassword(context: context, body: {
                              'user_id': userId.text,
                              'best_friend_name': bestFriend.text,
                              'password': newPassword.text
                            });
                          } else {
                            Utils.showSnackBar(
                                context: context,
                                message: 'password does not match!');
                          }
                        }
                        // showBottomSheet(context);
                      },
                      title: Constants.submit),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
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
                    Constants.passwordChanged,
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
