import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_vahan/components/display_dialog.dart';
import 'package:school_vahan/models/user_model.dart';
import 'package:school_vahan/screens/chooseLocation.dart';

import '../main.dart';
import '../user_state.dart';

class EnterUserDetails extends StatefulWidget {
  static String id = "enter_user_details";
  final String phone;
  final UserModel user;
  const EnterUserDetails({Key? key, required this.phone, required this.user})
      : super(key: key);
  @override
  _EnterUserDetailsState createState() => _EnterUserDetailsState();
}

class _EnterUserDetailsState extends State<EnterUserDetails> {
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _guardianNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String className = "";
  String latitude = '';
  String longitude = '';
  bool schoolNameAdded = false;
  bool busNameAdded = false;
  String selectedSchoolName = "";
  bool userHasToPay = false;
  DateTime selectedDate = DateTime.now();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  Map<String, String> schoolNames = {"Choose School": "Choose School"};
  String schoolDropDownValue = "Choose School";
  Map<String, String> busNames = {};
  String busDropDownValue = "Choose School Bus";
  String schoolName = "";
  String classDropDownValue = "Choose Standard";
  bool hasInput = false;

  bool busValuesLoaded = false;
  bool gotUserData = false;
  bool gotSchoolDetails = false;
  bool gotLocation = false;

  void getData() async {
    print(widget.user);
    if (widget.user.studentName != '') {
      _studentNameController.text = widget.user.studentName;
    }
    if (widget.user.guardianName != '') {
      _guardianNameController.text = widget.user.guardianName;
    }
    if (widget.user.address != '') {
      _addressController.text = widget.user.address;
    }
    if (widget.user.schoolId != '') {
      schoolDropDownValue = widget.user.schoolId;
    }
    if (widget.user.standard != '') {
      classDropDownValue = widget.user.standard;
    }
    if (widget.user.schoolName != '') {
      schoolName = widget.user.schoolName;
      schoolNameAdded = true;
    }
    if (widget.user.busNumber != '') {
      getBusesList();
    }
  }

  void getBusesList() async {
    busNames.clear();
    await _firebaseFirestore
        .collection("buses")
        .where('school_id', isEqualTo: schoolDropDownValue)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        busDropDownValue = "No Buses Found";
        busNames["No Buses Found"] = busDropDownValue;
      } else {
        busDropDownValue = widget.user.busNumber == ''
            ? "Choose School Bus"
            : widget.user.busNumber;
        // busNames['Choose School Bus'] = "Choose School Bus";
        busNames.addAll({"Choose School Bus": "Choose School Bus"});
        for (int i = 0; i < value.docs.length; i++) {
          busNames.addAll(
              {value.docs[i]['bus_driver_name']: value.docs[i]['bus_reg_no']});
          // busNames[value.docs[i]['bus_driver_name']] =
          //     value.docs[i]['bus_reg_no'];
        }
        setState(() {
          if (widget.user.busNumber != '') {
            busNameAdded = true;
          }
          busValuesLoaded = true;
        });
      }
    });
  }

  //TODO: Need a listener here
  void checkIfLocationExists() async {
    await secureStorage
        .read(key: "latitude")
        .then((value) => latitude = value!);
    await secureStorage
        .read(key: "longitude")
        .then((value) => longitude = value!);
    if (latitude != '' && longitude != '') {
      setState(() {
        gotLocation = true;
      });
    }
  }

  void getSchoolsList() async {
    await _firebaseFirestore.collection("schools").get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        schoolNames.addAll({value.docs[i]['school_name']: value.docs[i].id});
        // schoolNames[value.docs[i]['school_name']] = value.docs[i].id;
      }
      setState(() {
        gotSchoolDetails = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSchoolsList();
    getData();
  }

  @override
  void dispose() {
    _studentNameController.dispose();
    _guardianNameController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  var classes = [
    'Choose Standard',
    'L.K.G.',
    'U.K.G',
    '1st Class',
    '2nd Class',
    '3rd Class',
    '4th Class',
    '5th Class',
    '6th Class',
    '7th Class',
    '8th Class',
    '9th Class',
    '10th Class',
    '11th Class',
    '12th Class'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0Xffffd800),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(15.0, 30.0, 10.0, 10.0),
            child: Text(
              'Complete your profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    elevation: 8,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _studentNameController,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 10.0),
                        hintText: "Student's Name",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        hintStyle:
                            TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Card(
                    elevation: 8,
                    child: DropdownButtonFormField(
                        value: classDropDownValue,
                        items: classes
                            .map<DropdownMenuItem<String>>((String classNo) {
                          return DropdownMenuItem(
                            value: classNo,
                            child: Text(classNo),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                        onChanged: (String? value) {
                          setState(() => classDropDownValue = value!);
                        }),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Card(
                    elevation: 8,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _guardianNameController,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 10.0),
                        hintText: "Guardian's Name",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        hintStyle:
                            TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Card(
                    elevation: 8,
                    child: TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 10.0),
                        hintText: "Address",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        hintStyle:
                            TextStyle(color: Colors.grey[600], fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Card(
                    elevation: 8,
                    child: DropdownButtonFormField<String>(
                      value: schoolDropDownValue,
                      items: schoolNames
                          .map((description, value) {
                            return MapEntry(
                                description,
                                DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(description),
                                ));
                          })
                          .values
                          .toList(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        _firebaseFirestore
                            .collection('schools')
                            .doc(newValue)
                            .get()
                            .then((value) {
                          schoolName = value.get('school_name');
                          if (value.get('payment_made_by') == 'User') {
                            userHasToPay = true;
                          } else {
                            userHasToPay = false;
                          }
                        });
                        if (newValue != null) {
                          schoolDropDownValue = newValue;
                          getBusesList();
                          schoolNameAdded = true;
                          setState(() {
                            busValuesLoaded = true;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  busValuesLoaded
                      ? Card(
                          elevation: 8,
                          child: DropdownButtonFormField<String>(
                            value: busDropDownValue,
                            items: busNames
                                .map((description, value) {
                                  return MapEntry(
                                      description,
                                      DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          busDropDownValue == "No Buses Found"
                                              ? "No bus found"
                                              : value == "Choose School Bus"
                                                  ? "Choose School Bus"
                                                  : "$description : $value",
                                        ),
                                      ));
                                })
                                .values
                                .toList(),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                busDropDownValue = value!;
                              });
                              busNameAdded = true;
                            },
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 6.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          if (widget.user.lat == '') {
                            return const ChooseHomeLocation();
                          }
                          return ChooseHomeLocation(
                              lat: double.parse(widget.user.lat),
                              long: double.parse(widget.user.long));
                        }),
                      );
                    },
                    child: Text(
                      gotLocation
                          ? "Location Added"
                          : "Choose your home location",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 0.75, 40),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        final DateTime now = DateTime.now().add(
                          const Duration(days: 10000),
                        );
                        final DateFormat formatter = DateFormat('yyyy-MM-dd');
                        final String formatted = formatter.format(now);

                        await secureStorage
                            .read(key: "latitude")
                            .then((value) => latitude = value!);
                        await secureStorage
                            .read(key: "longitude")
                            .then((value) => longitude = value!);

                        if (latitude != '' &&
                            longitude != '' &&
                            busNameAdded &&
                            schoolNameAdded &&
                            classDropDownValue != "Choose Standard" &&
                            schoolDropDownValue != "Choose School" &&
                            busDropDownValue != "Choose School Bus" &&
                            _guardianNameController.text.isNotEmpty &&
                            _studentNameController.text.isNotEmpty) {
                          String? _uid = _user?.uid;
                          _firebaseFirestore.collection('user').doc(_uid).set({
                            'uid': _uid,
                            'school_id': schoolDropDownValue,
                            'student_name': _studentNameController.text,
                            'guardian_name': _guardianNameController.text,
                            'guardian_phone_number': widget.phone,
                            'standard': classDropDownValue,
                            "address": _addressController.text,
                            'school_name': schoolName,
                            'bus_number': busDropDownValue,
                            'latitude': latitude,
                            'longitude': longitude,
                            'subs_end_date': userHasToPay
                                ? '2023-06-30' // Todo: change later
                                : formatted,
                            'joined_on': selectedDate.toString()
                          }).then((value) {
                            secureStorage.write(
                                key: "subsEndDate", value: '2022-06-30');
                            int count = 0;
                            Navigator.of(context).popAndPushNamed(UserState.id);
                          }).onError((error, stackTrace) {
                            DisplayDialog.displayDialog(
                                context, "Error occured", "Try Again");
                            if (kDebugMode) {
                              print(error);
                            }
                          });
                        } else {
                          DisplayDialog.displayDialog(context, "Invalid Value",
                              "Please address all fields");
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: const Center(
                        child: Icon(Icons.arrow_forward_outlined,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
