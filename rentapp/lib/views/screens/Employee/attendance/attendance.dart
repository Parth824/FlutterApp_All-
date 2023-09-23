import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentapp/views/screens/Employee/attendance/add_attendance.dart';

import '../../../../main.dart';
import '../../../../size_config.dart';
import 'controllers/attendance_controller.dart';
import 'package:get/get.dart';



class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  static String routeName = "/attendance";

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DateTime date = DateTime.now();
  AttendanceController attendanceController = Get.put(AttendanceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder(
        future: attendanceController
            .getApiData(k: {"Id": '${sharedPreferences.getString("Id")}'}),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            return Obx(
              () => (attendanceController.Data.isEmpty)
                  ? Center(
                      child: Image.asset(
                        "assets/images/no-data.png",
                        height: 70,
                      ),
                    )
                  : ListView.builder(
                      itemCount: attendanceController.Data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:  EdgeInsets.all(12.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Text(
                                    "${attendanceController.Data[index]['Emp_Date']}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${attendanceController.Data[index]['P_A']}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddAttendance();
            },
          );
        },
        label: Text("Attendance"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
