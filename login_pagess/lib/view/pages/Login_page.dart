import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {



  final prefs =SharedPreferences.getInstance();

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormFieldState> _globalKey = GlobalKey<FormFieldState>();
  String Email = "";
  String Password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/login_page.png"),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _globalKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onSaved: (newValue) {
                        Email = newValue!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email Assress";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                        hintText: "Enter Email",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: pass,
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) {
                        Password = newValue!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter PassWord";
                        }
                        if (value.length < 6) {
                          return "Plases! Charechr of length";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                        hintText: "Enter Password",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 150,
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Colors.deepPurple,
                  ),
                ),
                onPressed: () {

                },
                child: Center(
                  child: Text("Login"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
