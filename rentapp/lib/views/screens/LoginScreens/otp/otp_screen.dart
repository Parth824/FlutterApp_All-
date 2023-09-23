import 'dart:isolate';

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:rentapp/views/screens/LoginScreens/signin/sign_in_screen.dart';

import '../../../../components/default_button.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../login_success/login_success_screen.dart';
import '../sign_up/sing_up_controller.dart';
import 'package:get/get.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  static String routeName = "/otp";

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  SingUpController singUpController = Get.put(SingUpController());
  late FocusNode pin2focusNode;
  late FocusNode pin3focusNode;
  late FocusNode pin4focusNode;
  TextEditingController e1 = TextEditingController();
  TextEditingController e2 = TextEditingController();
  TextEditingController e3 = TextEditingController();
  TextEditingController e4 = TextEditingController();

  EmailOTP myauth = EmailOTP();
  bool? isValid;
  String otp = "";
  @override
  void initState() {
    super.initState();
    pin2focusNode = FocusNode();
    pin3focusNode = FocusNode();
    pin4focusNode = FocusNode();
    sendOTP();
  }

  sendOTP() async {
    print("oo");
    myauth.setConfig(
        appEmail: "mohit@gmail.com",
        appName: "UD Services",
        userEmail: singUpController.E_P.value['Email'],
        otpLength: 4,
        otpType: OTPType.digitsOnly);
    isValid = await myauth.sendOTP();
  }

  @override
  void dispose() {
    pin2focusNode.dispose();
    pin3focusNode.dispose();
    pin4focusNode.dispose();
    super.dispose();
  }

  void nextField({String? val, FocusNode? focusNode}) {
    if (val!.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,

        title: Text("OTP Verification"),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
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
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                Text(
                  "OTP Verification",
                  style: headingStyle,
                ),
                Text(
                  "${singUpController.E_P['Email']}",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                buildTimer(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.15,
                ),
                Form(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: getProportionateScreenWidth(60),
                            child: TextFormField(
                              controller: e1,
                              autofocus: true,
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 24),
                              decoration: otpInputDecoration,
                              textAlign: TextAlign.center,
                              onChanged: (val) {
                                otp += val;
                                print(val);
                                nextField(val: val, focusNode: pin2focusNode);
                              },
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(60),
                            child: TextFormField(
                              controller: e2,
                              focusNode: pin2focusNode,
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 24),
                              decoration: otpInputDecoration,
                              textAlign: TextAlign.center,
                              onChanged: (val) {
                                otp += val;
                                print(val);
                                nextField(val: val, focusNode: pin3focusNode);
                              },
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(60),
                            child: TextFormField(
                              controller: e3,
                              focusNode: pin3focusNode,
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 24),
                              decoration: otpInputDecoration,
                              textAlign: TextAlign.center,
                              onChanged: (val) {
                                otp += val;
                                print(val);
                                nextField(val: val, focusNode: pin4focusNode);
                              },
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(60),
                            child: TextFormField(
                              controller: e4,
                              focusNode: pin4focusNode,
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 24),
                              decoration: otpInputDecoration,
                              textAlign: TextAlign.center,
                              onChanged: (val) {
                                otp += val;
                                pin4focusNode.unfocus();
                                print(val);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.15,
                      ),
                      DefaultButton(
                          text: "Continue",
                          press: () async {
                            print(otp);
                            if (isValid!) {
                              if (myauth.verifyOTP(otp: otp)) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  SigniInScreen.routeName,
                                  (route) {
                                    return false;
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("OTP Not Match..."),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Email Id InVaild.."),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ));
                            }
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                ),
                GestureDetector(
                  onTap: () {
                    sendOTP();
                  },
                  child: Text(
                    "Resend OTP Code",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "This code will expired in ",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        TweenAnimationBuilder(
          tween: Tween(
            begin: 30.0,
            end: 0,
          ),
          duration: Duration(seconds: 30),
          builder: (context, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
          onEnd: () {},
        ),
      ],
    );
  }
}
