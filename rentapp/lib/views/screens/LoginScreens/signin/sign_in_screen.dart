import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentapp/views/screens/Admin/homepage/homepage.dart';
import 'package:rentapp/views/screens/Employee/homepage/homepage.dart';
import '../../../../components/custom_suffix.dart';

import '../../../../components/form_error.dart';
import '../../../../components/signup_text.dart';
import '../../../../components/social_circle.dart';
import '../../../../constants.dart';
import '../../../../main.dart';
import '../../../../size_config.dart';
import '../../Doctor/homepage/homepage.dart';
import '../forgot_password/forgot_pass_screen.dart';

import '../select_category/select_category_controller.dart';
import 'cir_controller.dart';
import 'sign_in_controller.dart';


class SigniInScreen extends StatefulWidget {
  const SigniInScreen({Key? key}) : super(key: key);
  static String routeName = "/signin";

  @override
  State<SigniInScreen> createState() => _SigniInScreenState();
}

class _SigniInScreenState extends State<SigniInScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String? email;
  String? password;

  bool remember = false;


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

  int isDoc = 1;
  int isEmp = 0;
  CirController cirController = Get.put(CirController());

  Select_Cat_Controller select_cat_controller =
      Get.put(Select_Cat_Controller());
  SingInController singIpController = Get.put(SingInController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Sign in"),
          elevation: 0,
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
                  Image.asset('assets/images/logo.png'),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildEmailFormField(),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        buildPasswordFormField(),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ForgotPasswordScreen.routeName);
                              },
                              child: Text(
                                "Forgotton Password",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            )
                          ],
                        ),
                        FormError(errors: errors),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: getProportionateScreenHeight(56),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(kPrimaryColor),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                cirController.setLoding(isl: true);
                                if (email == "admin@gmail.com" &&
                                    password == "Mohit@123456") {
                                  await sharedPreferences.setBool(
                                      "isLogin", true);
                                  await sharedPreferences.setBool(
                                      "isAdmin", true);
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AdminHomePage.routeName,
                                    (route) {
                                      return false;
                                    },
                                  );
                                } else {
                                  await singIpController.getDoctor(
                                      isDoctor:
                                          select_cat_controller.isDoctor.value,
                                      Email: email!);
                                  if (singIpController.data.isNotEmpty) {
                                    if (password ==
                                        singIpController.data['Password']) {
                                      if (select_cat_controller
                                          .isDoctor.value) {
                                        await sharedPreferences.setBool(
                                            "isLogin", true);
                                        await sharedPreferences.setBool(
                                            "isDoctor",
                                            select_cat_controller
                                                .isDoctor.value);
                                        await sharedPreferences.setString("Id",
                                            singIpController.data['D_Id']);
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          DoctorHomePage.routeName,
                                          (route) {
                                            return false;
                                          },
                                        );
                                      } else {
                                        await sharedPreferences.setBool(
                                            "isLogin", true);
                                        await sharedPreferences.setBool(
                                            "isDoctor",
                                            select_cat_controller
                                                .isDoctor.value);
                                        await sharedPreferences.setString("Id",
                                            singIpController.data['E_Id']);
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          EmployeeHomePage.routeName,
                                          (route) {
                                            return false;
                                          },
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("PassWord InVaild.."),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                      ));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Sign Up User First.."),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                    ));
                                  }
                                }
                                cirController.setLoding(isl: false);
                              }
                            },
                            child: Obx(
                              () => cirController.isloding.value
                                  ? CircularProgressIndicator(color: Colors.white,)
                                  : Text(
                                      "Continue",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(18),
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(
                        () => SocialCircle(
                            icon: 'assets/images/doctor.png',
                            press: () {
                              select_cat_controller.updateIsDoctor(k: true);
                            },
                            color: (select_cat_controller.isDoctor.value)
                                ? Colors.blue.shade100
                                : Colors.grey.shade100),
                      ),
                      Obx(
                        () => SocialCircle(
                            icon: 'assets/images/employee.png',
                            press: () {
                              select_cat_controller.updateIsDoctor(k: false);
                            },
                            color:
                                (select_cat_controller.isDoctor.value == false)
                                    ? Colors.blue.shade100
                                    : Colors.grey.shade100),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(40),
                  ),
                  SignUpText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
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
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenHeight(25))),
        labelText: "Password",
        hintText: "Enter your password",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (val) {
        email = val;
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
