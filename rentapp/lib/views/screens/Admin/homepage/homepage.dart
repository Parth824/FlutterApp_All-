import 'package:rentapp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:rentapp/views/screens/Admin/addprinters/addprinters.dart';
import 'package:rentapp/views/screens/Admin/bankaccount/bankaccount.dart';
import 'package:rentapp/views/screens/Admin/doctor/doctor.dart';
import 'package:rentapp/views/screens/Admin/employee/employee.dart';
import 'package:rentapp/views/screens/Admin/expense/expense.dart';
import 'package:rentapp/views/screens/Admin/orderRequest/orderRequest.dart';
import 'package:rentapp/views/screens/Admin/payments/payments.dart';
import 'package:rentapp/views/screens/Admin/totalcomplains/totalcomplains.dart';
import 'package:rentapp/views/screens/Admin/totalsales/totalsales.dart';
import 'package:rentapp/views/screens/Doctor/payment_due/payment_due.dart';
import '../dashboard/dashboard.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
  static String routeName = "/admin";
}

class _AdminHomePageState extends State<AdminHomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var container;
    var text;
    if (currentPage == DrawerSections.dashboard) {
      container = DashboardPage();
      text = "Dashboard";
    } else if (currentPage == DrawerSections.doctor) {
      container = DoctorPage();
      text = "Doctor";
    } else if (currentPage == DrawerSections.employee) {
      container = EmployeePage();
      text = "Employee";
    } else if (currentPage == DrawerSections.orderRequest) {
      container = OrderRequest();
      text = "Order Request";
    } else if (currentPage == DrawerSections.expense) {
      container = ExpensePage();
      text = "Expense";
    } else if (currentPage == DrawerSections.bankaccount) {
      container = BankAccountPage();
      text = "Bank Account";
    } else if (currentPage == DrawerSections.payments) {
      container = PaymentsPage();
      text = "Payments";
    } else if (currentPage == DrawerSections.addprinters) {
      container = AddPrinterPage();
      text = "Add Items";
    } else if (currentPage == DrawerSections.totalsales) {
      container = TotalSalesPage();
      text = "Total Sales";
    } else if (currentPage == DrawerSections.totalcomplain) {
      container = TotalComplainsPage();
      text = "Total Complains";
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
          menuItem(1, "Dashboard",
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Doctors",
              currentPage == DrawerSections.doctor ? true : false),
          menuItem(3, "Employees",
              currentPage == DrawerSections.employee ? true : false),
          menuItem(4, "Order Request",
              currentPage == DrawerSections.orderRequest ? true : false),
          menuItem(5, "Expense",
              currentPage == DrawerSections.expense ? true : false),
          menuItem(6, "Bank Account",
              currentPage == DrawerSections.bankaccount ? true : false),
          menuItem(7, "Payments",
              currentPage == DrawerSections.payments ? true : false),
          menuItem(8, "Add Items",
              currentPage == DrawerSections.addprinters ? true : false),
          menuItem(9, "Total Sales",
              currentPage == DrawerSections.totalsales ? true : false),
          menuItem(10, "Total Complains",
              currentPage == DrawerSections.totalcomplain ? true : false),
          menuItem(11, "Logout",
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
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.doctor;
            } else if (id == 3) {
              currentPage = DrawerSections.employee;
            } else if (id == 4) {
              currentPage = DrawerSections.orderRequest;
            } else if (id == 5) {
              currentPage = DrawerSections.expense;
            } else if (id == 6) {
              currentPage = DrawerSections.bankaccount;
            } else if (id == 7) {
              currentPage = DrawerSections.payments;
            } else if (id == 8) {
              currentPage = DrawerSections.addprinters;
            } else if (id == 9) {
              currentPage = DrawerSections.totalsales;
            } else if (id == 10) {
              currentPage = DrawerSections.totalcomplain;
            }else if (id == 11) {
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
  dashboard,
  doctor,
  employee,
  orderRequest,
  expense,
  bankaccount,
  payments,
  addprinters,
  totalsales,
  totalcomplain,
  logout,
}
