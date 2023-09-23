import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';
import '../../../../size_config.dart';
import '../../Doctor/complain/cir_contoroller.dart';
import 'attendance.dart';
import 'package:get/get.dart';

import 'controllers/attendance_controller.dart';
import 'controllers/chang_controller.dart';

class AddAttendance extends StatefulWidget {
  const AddAttendance({super.key});

  @override
  State<AddAttendance> createState() => _AddAttendanceState();
}

class _AddAttendanceState extends State<AddAttendance> {
  DateTime date = DateTime.now();
  CahngColorController cahngColorController = Get.put(CahngColorController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text("Add Attendance"),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            cahngColorController.setLoding(isl: true);
            await cahngColorController.getApiData(k: {
              'E_Id': '${sharedPreferences.getString("Id")}',
              'Date': '${DateFormat('yyyy-MM-dd').format(date)}'
            });
            if (cahngColorController.Data.isEmpty) {
              Map k = {
                'E_Id': '${sharedPreferences.getString("Id")}',
                'Emp_Date': '${DateFormat('yyyy-MM-dd').format(date)}',
                'P_A': (cahngColorController.Chang.value) ? 'P' : 'A'
              };
            
              await cahngColorController.addData(k: k);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("ADD Attendance Alertd.."),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                          ));
            }
           cahngColorController.setLoding(isl: false);
            Navigator.pop(context);
          },
          child: Text(
            "Add",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      content: GestureDetector(
        onTap: () {
          cahngColorController.getChang();
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx(
            () => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: (cahngColorController.Chang.value)
                    ? Colors.green
                    : Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                   (cahngColorController.isloding.value)? CircularProgressIndicator(color: Colors.white,) : Text(
                      "${DateFormat('yyyy-MM-dd').format(date)}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                          color: Colors.white),
                    ),
                    Spacer(),
                   (cahngColorController.Chang == false)
                        ? Text(
                            "A",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                                color: Colors.white),
                          )
                        : Text(
                            "P",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                                color: Colors.white),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
