import 'package:chat_gpt/constant/app_assets.dart';
import 'package:chat_gpt/screens/signup_pages/signup_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../login_page/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  SingupController singupController = Get.put(SingupController());
  String? fname;
  String? lname;
  String? email;
  String? password;

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  bool isValidEmail(String val) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(val);
  }

  bool isValidName(String val) {
    final nameRegExp =
         RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
    return nameRegExp.hasMatch(val);
  }

  bool isValidPassword(String val) {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return passwordRegExp.hasMatch(val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Form(
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titleText(),
                  const SizedBox(height: 40),
                  _formFields(),
                  const SizedBox(height: 22),
                  _signupButton(),
                  const SizedBox(height: 16),
                  _loginScreen(context),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          _backButton(context)
        ]),
      ),
    );
  }

  Widget _titleText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: RichText(
        text: TextSpan(
          text: 'Sign up',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 58),
          children: <TextSpan>[
            TextSpan(text: '.', style: TextStyle(color: Color(0xff3FB085))),
          ],
        ),
      ),
    );
  }

  Widget _formFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('First Name',
            style: TextStyle(fontSize: 16, color: Colors.grey[50])),
        const SizedBox(height: 8),
        TextFormField(
          showCursor: false,
          textCapitalization: TextCapitalization.sentences,
          controller: fnamecontroller,
          onSaved: (newValue) {
            fname = newValue;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "required !";
            } else if (isValidName(value)) {
              return "Enter Valid Name";
            }
          },
          decoration: InputDecoration(
            hintText: 'Parth',
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
        Text('Last Name',
            style: TextStyle(fontSize: 16, color: Colors.grey[50])),
        const SizedBox(height: 8),
        TextFormField(
          showCursor: false,
          textCapitalization: TextCapitalization.sentences,
          controller: lnamecontroller,
          onSaved: (newValue) {
            lname = newValue;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "required !";
            } else if (isValidName(value)) {
              return "Enter Valid Name";
            }
          },
          decoration: InputDecoration(
            hintText: 'Dhameliya',
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
            hintText: 'Parth@gmail.com',
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
      ],
    );
  }

  Widget _signupButton() {
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

                var data = await singupController.InsertUser(k: {
                  'First_Name': fnamecontroller.text,
                  'Last_Name': lnamecontroller.text,
                  'Email_Id': emailcontroller.text,
                  'Password': passwordcontroller.text
                });
                if (data['result'] == "Have User") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Already Have User"),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (data['result'] == "Insert Succfully") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Signup..."),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Login Faild"),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
              setState(() {});
            },
            child: Obx(
              () => (singupController.isLoading.value)
                  ? Lottie.asset(AppAssets.loadingFile, height: 20)
                  : Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget _loginScreen(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(width: 5),
          const Text(
            'Login',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Positioned(
      top: 10,
      left: 0,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child:
                    Icon(Icons.keyboard_arrow_left, color: Colors.grey.shade50),
              ),
              Text('Back',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade50))
            ],
          ),
        ),
      ),
    );
  }
}
