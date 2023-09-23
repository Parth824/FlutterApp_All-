import 'package:flutter/material.dart';
import 'package:rentapp/views/screens/Employee/attendance/attendance.dart';
import 'package:rentapp/views/screens/Employee/dailyexpenses/daliy_expenses.dart';
import 'package:rentapp/views/screens/Employee/orderdelivery/orderdelivery.dart';

import '../../../../size_config.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({super.key});

   static String routeName = "/employee";
  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  var currentPage = DrawerSections.orderdelivery;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var container;
    var text;
    if (currentPage == DrawerSections.orderdelivery) {
      container = OrderDeliveryPage();
      text = "Order Deliver";
    } else if (currentPage == DrawerSections.daliyexpenses) {
      container = DaliyExpensesPage();
      text = "Daliy Expenses";
    } else if (currentPage == DrawerSections.attendance) {
      container = AttendancePage();
      text = "Employee Attendance";
    } else if (currentPage == DrawerSections.logout) {
      // container = TotalComplainsPage();
      // text = "Total Complains";
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.blue,
          title: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: container,
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  height: SizeConfig.screenHeight * 0.2,
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.all(getProportionateScreenHeight(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "UD Services",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenHeight(18),
                              ),
                            ),
                            Text(
                              "email",
                              style: TextStyle(
                                color: Colors.grey[200],
                                fontSize: getProportionateScreenHeight(14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: getProportionateScreenHeight(5),
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Order Deliver",
              currentPage == DrawerSections.orderdelivery ? true : false),
          menuItem(2, "Daliy Expenses",
              currentPage == DrawerSections.daliyexpenses ? true : false),
          menuItem(3, "Employee Attendance",
              currentPage == DrawerSections.attendance ? true : false),
          menuItem(4, "Logout",
              currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.orderdelivery;
            } else if (id == 2) {
              currentPage = DrawerSections.daliyexpenses;
            } else if (id == 3) {
              currentPage = DrawerSections.attendance;

            }else if (id == 4) {
              currentPage = DrawerSections.logout;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(15)),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenHeight(15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  orderdelivery,
  attendance,
  daliyexpenses,
  logout,
}