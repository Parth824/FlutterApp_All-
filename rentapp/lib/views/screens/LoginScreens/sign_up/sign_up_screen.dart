import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/custom_suffix.dart';
import '../../../../components/default_button.dart';
import '../../../../components/form_error.dart';
import '../../../../components/social_circle.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../complete_profile/complete_profile_screen.dart';
import '../select_category/select_category_controller.dart';
import 'sing_up_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static String routeName = '/sign_up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String? password;
  String? confirmPassword;

  final List<String> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Select_Cat_Controller select_cat_controller =
      Get.find<Select_Cat_Controller>();
  SingUpController singUpController = Get.put(SingUpController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Sign Up"),
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  // SizedBox(
                  //   height: SizeConfig.screenHeight * 0.03,
                  // ),
                  // Text(
                  //   "Register Account",
                  //   style: headingStyle,
                  // ),
                  // Text(
                  //   "Complete your details or continue \nwith social media",
                  //   textAlign: TextAlign.center,
                  // ),
                  Image.asset('assets/images/logo.png'),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildEmailFormField(),
                        SizedBox(
                          height: getProportionateScreenHeight(30),
                        ),
                        buildPasswordFormField(),
                        SizedBox(
                          height: getProportionateScreenHeight(30),
                        ),
                        buildConfirmPassFormField(),
                        FormError(errors: errors),
                        SizedBox(
                          height: getProportionateScreenHeight(40),
                        ),
                        DefaultButton(
                            text: "Continue",
                            press: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                await singUpController.getDoctor(
                                    isDoctor:
                                        select_cat_controller.isDoctor.value,
                                    Email: email);
                                if (singUpController.data.isNotEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Have User"),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                } else {
                                  singUpController.E_P.value = {
                                    'Email': email,
                                    'Password': password
                                  };
                                  Navigator.pushNamed(
                                    context,
                                    CompleteProfileScreen.routeName,
                                  );
                                }
                              }
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.07,
                  ),

                  Text(
                    "By continuing your confirm that you agree \nwith our Term and Condition",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      // onSaved: (newValue) => confirmPassword = newValue,
      // onChanged: (value) {
      //   if (password==confirmPassword) {
      //     removeError(error: kPassNullError);
      //   } else if (value.length >= 8) {
      //     removeError(error: kShortPassError);
      //   }
      //   return null;
      // },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kPassNullError);
      //     return "";
      //   } else if (value.length < 8) {
      //     addError(error: kShortPassError);
      //     return "";
      //   }
      //   return null;
      // },
      onSaved: (val) {
        confirmPassword = val;
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.isNotEmpty &&
            password == confirmPassword &&
            errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kMatchPassError);
          });
          return;
        }
        confirmPassword = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        } else if (password != value && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kMatchPassError);
          });
          return "";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenHeight(25))),
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      // onSaved: (newValue) => password = newValue,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kPassNullError);
      //   } else if (value.length >= 8) {
      //     removeError(error: kShortPassError);
      //   }
      //   return null;
      // },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kPassNullError);
      //     return "";
      //   } else if (value.length < 8) {
      //     addError(error: kShortPassError);
      //     return "";
      //   }
      //   return null;
      // },
      onSaved: (val) {
        password = val;
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
          return;
        }

        password = value;
        return;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
          return "";
        } else if (value.length < 8 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
          });
          return "";
        }
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      obscureText: true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: "Password",
        enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenHeight(25))),
        hintText: "Enter your password",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (val) {
        email = val!;
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
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
        if (value!.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
          });
          return "";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenHeight(25))),
        labelText: "Email",
        hintText: "Enter your email",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
