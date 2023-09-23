import 'package:chat_gpt/constant/app_assets.dart';
import 'package:chat_gpt/screens/home_pages/home_screen.dart';
import 'package:chat_gpt/screens/login_page/login_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../signup_pages/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  LoginController loginController = Get.put(LoginController());
  String? email;
  String? password;

  setLogin(String name, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(name, val);
  }

  setId(String name, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, val);
  }

  bool isValidEmail(String val) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(val);
  }

  bool isValidName(String val) {
    final nameRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
    return nameRegExp.hasMatch(val);
  }

  bool isValidPassword(String val) {
    final passwordRegExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegExp.hasMatch(val);
  }

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleText(),
              const SizedBox(height: 40),
              _formFields(context),
              const SizedBox(height: 16),
              _signinButton(),
              _divider(),
              _socialLogins(),
              const SizedBox(height: 16),
              _signupButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: RichText(
        text: TextSpan(
          text: 'Sign in',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 58),
          children: <TextSpan>[
            TextSpan(text: '.', style: TextStyle(color: Color(0xff3FB085))),
          ],
        ),
      ),
    );
  }

  Widget _formFields(context) {
    return Form(
      key: globalKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email', style: TextStyle(fontSize: 16, color: Colors.grey[50])),
          const SizedBox(height: 8),
          TextFormField(
            showCursor: false,
            textCapitalization: TextCapitalization.sentences,
            controller: emailcontroller,
            onSaved: (newValue) {
              email = newValue;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "required !";
              } else if (!isValidEmail(value)) {
                return "Enter Valid Email";
              }
            },
            decoration: InputDecoration(
              hintText: 'parth@gmail.com',
              hintStyle: TextStyle(color: Colors.grey.shade600),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.grey.shade800,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff3FB085), width: 2.0),
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: Colors.grey[900],
              filled: true,
              contentPadding: const EdgeInsets.all(19),
            ),
            style: TextStyle(color: Colors.grey[50], fontSize: 17),
          ),
          const SizedBox(height: 22),
          Text('Password',
              style: TextStyle(fontSize: 16, color: Colors.grey[50])),
          const SizedBox(height: 8),
          TextFormField(
            showCursor: false,
            obscureText: true,
            textCapitalization: TextCapitalization.sentences,
            controller: passwordcontroller,
            onSaved: (newValue) {
              password = newValue;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "required !";
              } else if (!isValidPassword(value)) {
                return "Enter Valid Password";
              }
            },
            decoration: InputDecoration(
              hintText: 'Enter your password',
              hintStyle: TextStyle(color: Colors.grey.shade600),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.grey.shade800,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff3FB085), width: 2.0),
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: Colors.grey[900],
              filled: true,
              contentPadding: const EdgeInsets.all(19),
            ),
            style: TextStyle(color: Colors.grey[50], fontSize: 17),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const ForgotPasswordScreen()),
                // );
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3FB085),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signinButton() {
    return Row(children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [0.0, 1.0],
              colors: [
                Color(0xff3FB085),
                Color(0xff3FB085),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.transparent,
              ),
            ),
            onPressed: () async {
              if (globalKey.currentState!.validate()) {
                globalKey.currentState!.save();

                var data = await loginController.LoginUser(k: {
                  'Email_Id': emailcontroller.text,
                  'Password': passwordcontroller.text
                });
                if (data['data'] == "Sign in successfully...") {
                  await setLogin("isLoginScreen", true);
                  print("${data['U_Id']}");
                  await setId("id", "${data['U_Id']}");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Sign in successfully..."),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Sign in failed..."),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
              setState(() {});
            },
            child: Obx(() => (loginController.isLoading.value)
                ? Lottie.asset(AppAssets.loadingFile, height: 20)
                : Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
          ),
        ),
      ),
    ]);
  }

  _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          Text(
            'or',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 15,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  _socialLogins() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              border: Border.all(color: Colors.grey.shade800),
              borderRadius: const BorderRadius.all(Radius.circular(
                      12.0) //                 <--- border radius here
                  ),
            ),
            child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(
                  Icons.g_mobiledata,
                  size: 40,
                  color: Colors.white,
                )),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              border: Border.all(color: Colors.grey.shade800),
              borderRadius: const BorderRadius.all(Radius.circular(
                      12.0) //                 <--- border radius here
                  ),
            ),
            child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(
                  Icons.apple,
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }

  Widget _signupButton(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignupScreen()),
        );
      }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Dont have an account?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(width: 5),
          const Text(
            'Sign up',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
