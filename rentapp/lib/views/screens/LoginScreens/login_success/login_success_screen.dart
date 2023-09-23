import 'package:flutter/material.dart';
import 'package:rentapp/views/screens/Admin/homepage/homepage.dart';
import 'package:rentapp/views/screens/Doctor/homepage/homepage.dart';

import '../../../../components/default_button.dart';
import '../../../../size_config.dart';

class LoginSuccessScreen extends StatefulWidget {
  const LoginSuccessScreen({Key? key}) : super(key: key);
  static String routeName = "/login_success";

  @override
  State<LoginSuccessScreen> createState() => _LoginSuccessScreenState();
}

class _LoginSuccessScreenState extends State<LoginSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,
        backgroundColor: Colors.white,
        leading: Container(),
        title: Text("Login Success"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          Image.asset(
            "assets/images/success.png",
            height: SizeConfig.screenHeight * 0.4,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.08,
          ),
          Text(
            "Login Success",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.08,
          ),
          SizedBox(
            width: SizeConfig.screenWidth * 0.5,
            child: DefaultButton(
              text: "Back to home",
              press: () {
                Navigator.pushNamed(context, AdminHomePage.routeName);
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
