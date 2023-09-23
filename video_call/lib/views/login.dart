import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:videocall_app/providers/auth_provider.dart';
import 'package:videocall_app/utils/constants/constant.dart';
import 'package:videocall_app/utils/router/router_path.dart';
import 'package:videocall_app/views/widgets/basic_ui.dart';
import 'package:videocall_app/views/widgets/button.dart';
import 'package:videocall_app/views/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userId = TextEditingController();
  TextEditingController password = TextEditingController();
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
      onTap: () {},
      widget: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: formstate,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        Constants.login,
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
                        height: 40,
                      ),
                      ButtonWidget(
                          onTap: () async {
                            if (formstate.currentState?.validate() == true) {
                              String? token =
                                  await FirebaseMessaging.instance.getToken();
                              authProvider.login(context: context, body: {
                                'user_id': userId.text,
                                'password': password.text,
                                'fcm_token': token
                              });
                            }
                            // Navigator.pushNamed(context, RoutePath.home);
                          },
                          title: Constants.login),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutePath.forgotPassword);
                        },
                        child: Text(
                          Constants.forgotPassword,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.viga(
                              fontSize: 14, color: const Color(0xFF707070)),
                        ),
                      ),
                      // const Spacer(),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Constants.donHaveAccount,
                              style: GoogleFonts.viga(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF707070))),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RoutePath.register);
                            },
                            child: Text(
                              " ${Constants.signUp}",
                              style: GoogleFonts.viga(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
