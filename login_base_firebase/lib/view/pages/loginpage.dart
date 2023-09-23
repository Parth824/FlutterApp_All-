import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_base_firebase/helper/FCMnotificationhlper.dart';
import 'package:login_base_firebase/helper/Notification_hlper.dart';
import 'package:login_base_firebase/helper/firbase_hlper.dart';
import 'package:login_base_firebase/view/pages/homepages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  String? email1;
  String? password1;

  GlobalKey<FormState> _singup = GlobalKey<FormState>();
  GlobalKey<FormState> _singin = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _email1 = TextEditingController();
  TextEditingController _password1 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationHlper.notificationHlper.intinotfication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () async {
                await FCMNotifiationHlper.fcmNotifiationHlper.getapi();
              },
              child: Text("FCM Notifications"),
            ),
            OutlinedButton(
              onPressed: () async {
                await NotificationHlper.notificationHlper
                    .showSimpleNotification(
                        tital: "Parth", body: "I am Potea...");
              },
              child: Text("Simple Notifications"),
            ),
            OutlinedButton(
              onPressed: () async {
                await NotificationHlper.notificationHlper
                    .showShudingNotification();
              },
              child: Text("Scheduling Notifications"),
            ),
            OutlinedButton(
              onPressed: () async {
                await NotificationHlper.notificationHlper
                    .showBigPicNotification();
              },
              child: Text("Big Pic Notifications"),
            ),
            OutlinedButton(
              onPressed: () async {
                await NotificationHlper.notificationHlper
                    .showMediaStyleNotification();
              },
              child: Text("Media Notifications"),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                AnAnonymous_Logik();
              },
              child: Text("Anonymous"),
            ),
            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    signup();
                  },
                  child: Text("Sing Up"),
                ),
                ElevatedButton(
                  onPressed: () {
                    signIn();
                  },
                  child: Text("Sing In"),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Login_Google();
              },
              child: Text("Login With Googles"),
            ),
          ],
        ),
      ),
    );
  }

  AnAnonymous_Logik() async {
    Map<String, dynamic> user = await Firbase_Hlper.fireHleper.annauser();
    if (user['user'] != null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Succfully..."),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed('/', arguments: user['user']);
    } else if (user['error'] != null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(user['error']),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Faild..."),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Singn In"),
          content: Form(
            key: _singin,
            child: Container(
              height: 212,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _email1,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) {
                      setState(() {
                        email1 = val;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter The EmailID.....";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _password1,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) {
                      setState(() {
                        password1 = val;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the PassWord";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (_singin.currentState!.validate()) {
                  _singin.currentState!.save();
                  print(email1);
                  print(password1);
                  Map<String, dynamic> user = await Firbase_Hlper.fireHleper
                      .sign_In(email: email1!, password: password1!);
                  print(user['user']);
                  Navigator.pop(context);
                  if (user['user'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Sing In Succfully..."),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                        settings: RouteSettings(
                          arguments: user['user'],
                        ),
                      ),
                    );
                  } else if (user['error'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${user['error']}"),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Singn In Faild..."),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                  print("Parth");
                  _email1.clear();
                  _password1.clear();

                  setState(() {
                    email1 = "";
                    password1 = "";
                  });
                } else {}
              },
              child: Text("Ok"),
            ),
            OutlinedButton(
              onPressed: () {
                _email1.clear();
                _password1.clear();

                setState(() {
                  email = "";
                  password = "";
                });
                Navigator.pop(context);
              },
              child: Text("Clanle"),
            ),
          ],
        );
      },
    );
  }

  signup() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Singn Up"),
          content: Form(
            key: _singup,
            child: Container(
              height: 212,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter The EmailID.....";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _password,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter the PassWord";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (_singup.currentState!.validate()) {
                  _singup.currentState!.save();
                  Map<String, dynamic> user = await Firbase_Hlper.fireHleper
                      .sign_up(email: email!, password: password!);
                  if (user['user'] != null) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Sing Up Succfully..."),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    // ignore: use_build_context_synchronously
                  } else if (user['error'] != null) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${user['error']}"),
                        backgroundColor: Colors.redAccent,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Sing Up Faild..."),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                  print("Parth");
                  _email.clear();
                  _password.clear();

                  setState(() {
                    email = "";
                    password = "";
                  });
                  Navigator.pop(context);
                } else {}
              },
              child: Text("Ok"),
            ),
            OutlinedButton(
              onPressed: () {
                _email.clear();
                _password.clear();

                setState(() {
                  email = "";
                  password = "";
                });
                Navigator.pop(context);
              },
              child: Text("Clanse"),
            ),
          ],
        );
      },
    );
  }

  Login_Google() async {
    Map<String, dynamic> user =
        await Firbase_Hlper.fireHleper.google_with_login();

    if (user['user'] != null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Succfully..."),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed(
        '/',
        arguments: user['user'],
      );
    } else if (user['error'] != null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(user['error']),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Faild..."),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
