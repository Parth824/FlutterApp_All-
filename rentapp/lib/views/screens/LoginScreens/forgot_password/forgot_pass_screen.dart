import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/custom_suffix.dart';
import '../../../../components/default_button.dart';
import '../../../../components/form_error.dart';
import '../../../../components/signup_text.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../select_category/select_category_controller.dart';
import '../signin/sign_in_controller.dart';
import '../signin/sign_in_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static String routeName = "/forgot_password";

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;
  EmailOTP myauth = EmailOTP();

  Select_Cat_Controller select_cat_controller =
      Get.find<Select_Cat_Controller>();
  SingInController singInController = Get.put(SingInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Forgot Password"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Please enter your email and we will send \nyou a link to return to your account",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (val) {
                          email = val;
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty &&
                              errors.contains(kEmailNullError)) {
                            setState(() {
                              errors.remove(kEmailNullError);
                            });
                          } else if (emailValidatorRegExp.hasMatch(value) &&
                              errors.contains(kInvalidEmailError)) {
                            setState(() {
                              errors.remove(kInvalidEmailError);
                            });
                          }
                          return;
                        },
                        validator: (value) {
                          if (value!.isEmpty &&
                              !errors.contains(kEmailNullError)) {
                            setState(() {
                              errors.add(kEmailNullError);
                            });
                          } else if (!emailValidatorRegExp.hasMatch(value) &&
                              !errors.contains(kInvalidEmailError)) {
                            setState(() {
                              errors.add(kInvalidEmailError);
                            });
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  getProportionateScreenHeight(25))),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Email",
                          hintText: "Enter your email",
                          suffixIcon: CustomSuffixIcon(
                              svgIcon: "assets/icons/Mail.svg"),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      FormError(errors: errors),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.1,
                      ),
                      DefaultButton(
                          text: "Continue",
                          press: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await singInController.getDoctor(
                                  isDoctor:
                                      select_cat_controller.isDoctor.value,
                                  Email: email!);
                              print("${singInController.data['Password']}");
                              if (singInController.data.isNotEmpty) {
                                myauth.setConfig(
                                    // appEmail:
                                    //     "Password: ${singInController.data['Password']}",
                                    appName: "UD Services\nPassword : ${singInController.data['Password']}",
                                    userEmail: singInController.data['Email'],
                                    otpLength: 4,
                                    otpType: OTPType.digitsOnly);
                                if (await myauth.sendOTP()) {
                                  Navigator.pushNamed(
                                    context,
                                    SigniInScreen.routeName,
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Not Have User..."),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ));

                                Navigator.pushNamed(
                                  context,
                                  SigniInScreen.routeName,
                                );
                              }
                            }
                          }),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.1,
                      ),
                      SignUpText(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

