import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_vahan/models/user_model.dart';
import 'package:school_vahan/screens/update_user_details.dart';

class Profile extends StatefulWidget {
  final UserModel user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String driverName = "";
  late String driverNumber;
  late String schoolNumber;
  bool busLoaded = false;
  bool schoolLoaded = false;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void getDriverNumber() async {
    await _firebaseFirestore
        .collection("schools")
        .doc(widget.user.schoolId)
        .get()
        .then((value) {
      // print(value.docs[0]["school_phnumber"]);

      schoolNumber = value.get("school_phnumber");
      setState(() {
        schoolLoaded = true;
      });
    });
    await _firebaseFirestore
        .collection("buses")
        .where('bus_reg_no', isEqualTo: widget.user.busNumber)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        driverName = "";
      } else {
        driverName = value.docs[0]["bus_driver_name"];
        driverNumber = value.docs[0]["bus_driver_phno"];
        setState(() {
          busLoaded = true;
        });
      }
    });
  }

  // void getSchoolsNumber() async {
  //   await _firebaseFirestore
  //       .collection("schools")
  //       .where("school_name", isEqualTo: widget.user.schoolName)
  //       .get()
  //       .then((value) {
  //     print("asdf");
  //     if (value.docs.isEmpty) {
  //       schoolNumber = "";
  //     } else {
  //       schoolNumber = value.docs[0]["school_phnumber"];
  //       print(schoolNumber);
  //       setState(() {
  //         schoolLoaded = true;
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    getDriverNumber();
    // getSchoolsNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0Xffffd800),
      body: schoolLoaded == true && busLoaded == true
          ? ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 0.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.user.studentName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              "CLASS - ${widget.user.standard}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          // CircleAvatar(
                          //   backgroundColor:Colors.black,
                          //   radius: 30,
                          //   child:Icon(Icons.person, color: Colors.amberAccent),
                          // ),
                          // SizedBox(height:10.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EnterUserDetails(
                                      phone: widget.user.guardianPhNo,
                                      user: widget.user,
                                    ),
                                  ));
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            child: const Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 0.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25.0),
                          const Text(
                            "School's Name",
                          ),
                          const SizedBox(height: 10.0),
                          Text(widget.user.schoolName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              )),
                          const SizedBox(height: 20.0),
                          const Text("Guardian's Name"),
                          const SizedBox(height: 10.0),
                          Text(widget.user.guardianName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              )),
                          const SizedBox(height: 20.0),
                          const Text("Mobile No."),
                          const SizedBox(height: 10.0),
                          Text(
                            widget.user.guardianPhNo,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          const Text("Vehicle's No."),
                          const SizedBox(height: 10.0),
                          Text(widget.user.busNumber,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              )),
                          const SizedBox(height: 20.0),
                          // const Text("Vehicle's Code"),
                          // const SizedBox(height: 10.0),
                          // const Text("XXXXX",
                          //     style: TextStyle(
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 16.0,
                          //     )),
                          // const SizedBox(height: 20.0),
                          const Text("Driver's Name"),
                          const SizedBox(height: 10.0),
                          Text(driverName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              )),
                          const SizedBox(height: 20.0),
                          const Text(
                            "Driver's Mobile No",
                          ),
                          const SizedBox(height: 10.0),
                          Text(driverNumber,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              )),
                          const SizedBox(height: 20.0),
                          const Text("School's Helpline No."),
                          const SizedBox(height: 10.0),
                          Text(schoolNumber,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              )),
                          const SizedBox(height: 20.0),

                          // new Row(
                          //     mainAxisAlignment:MainAxisAlignment.end,
                          //     children: [
                          //       ButtonTheme(
                          //         minWidth:140.0,
                          //         child: new RaisedButton(
                          //           color:Colors.black,
                          //           padding:EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
                          //           child:Text("Payment", style:TextStyle(color:Colors.white)),
                          //           onPressed: (){},
                          //         ),
                          //       ),
                          //     ]
                          // ),
                          const SizedBox(height: 30.0),
                        ])),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
