import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Homa_page.dart';
import 'hleper.dart';

class restiomPage extends StatefulWidget {
  const restiomPage({Key? key}) : super(key: key);

  @override
  State<restiomPage> createState() => _restiomPageState();
}

class _restiomPageState extends State<restiomPage> {
  late SharedPreferences spft;

  TextEditingController pass_word = TextEditingController();
  TextEditingController Email_adder = TextEditingController();

  String email = "";
  String passWord = "";

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  makeshar() async {
    spft = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeshar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: Image.asset("assets/images/k2.png"),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _globalKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: Email_adder,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          email = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* Required';
                          } else {
                            if (Helper.helper.validateStructureemail(value)) {
                              return null;
                            } else {
                              return "Enter a valid Email";
                            }
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          hintText: "Enter The Email",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: pass_word,
                        keyboardType: TextInputType.number,
                        // textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          passWord = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '* Required';
                          } else {
                            if (Helper.helper.validateStructure(value)) {
                              return null;
                            } else {
                              return "Password must be least 8 chars, 1 uppercase, 1 lowercase, 1 number, special chars";
                            }
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          hintText: "Enter The Password",
                        ),
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
              height: 45,
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  List<String>? k = await spft.getStringList("Loginn");

                  _globalKey.currentState!.save();
                  await spft.setBool("t", true);
                  if (k![0] == email && k[1] == passWord) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.deepPurple),
                ),
                child: Text("registration "),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
