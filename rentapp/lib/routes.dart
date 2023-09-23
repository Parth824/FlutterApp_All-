import 'package:flutter/material.dart';
import 'package:rentapp/views/screens/Admin/homepage/homepage.dart';
import 'package:rentapp/views/screens/Doctor/complain/complain.dart';
import 'package:rentapp/views/screens/Doctor/homepage/homepage.dart';
import 'package:rentapp/views/screens/Doctor/ledger/ledger.dart';
import 'package:rentapp/views/screens/Doctor/order/order_page.dart';
import 'package:rentapp/views/screens/Doctor/order/payment_order_page.dart';
import 'package:rentapp/views/screens/Doctor/order/printer_details_screen.dart';
import 'package:rentapp/views/screens/Doctor/order_received/order_recevied.dart';
import 'package:rentapp/views/screens/Doctor/payment/payment.dart';
import 'package:rentapp/views/screens/Doctor/payment_due/payment_due.dart';
import 'package:rentapp/views/screens/Employee/attendance/attendance.dart';
import 'package:rentapp/views/screens/Employee/dailyexpenses/daliy_expenses.dart';
import 'package:rentapp/views/screens/Employee/homepage/homepage.dart';
import 'package:rentapp/views/screens/Employee/orderdelivery/orderdelivery.dart';
import 'package:rentapp/views/screens/LoginScreens/complete_profile/complete_profile_screen.dart';
import 'package:rentapp/views/screens/LoginScreens/forgot_password/forgot_pass_screen.dart';
import 'package:rentapp/views/screens/LoginScreens/login_success/login_success_screen.dart';
import 'package:rentapp/views/screens/LoginScreens/otp/otp_screen.dart';
import 'package:rentapp/views/screens/LoginScreens/select_category/select_category_screen.dart';
import 'package:rentapp/views/screens/LoginScreens/sign_up/sign_up_screen.dart';
import 'package:rentapp/views/screens/LoginScreens/signin/sign_in_screen.dart';

final Map<String, WidgetBuilder> routes = {
  // SplashScreen.routeName: (context) => SplashScreen(),
  SigniInScreen.routeName: (context) => SigniInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  SelectCategory.routeName: (context) => SelectCategory(),
  DoctorHomePage.routeName: (context) => DoctorHomePage(),
  Order_Page.routeName: (context) => Order_Page(),
  PrinterDetails.routeName: (context) => PrinterDetails(),
  PaymentPage.routeName: (context) => PaymentPage(),
  ComplainPage.routeName:(context)=>ComplainPage(),
  OrderReceivedPage.routeName: (context) => OrderReceivedPage(),
  LedgerPage.routeName:(context)=>LedgerPage(),
  PaymentDuePage.routeName:(context)=>PaymentDuePage(),
  AdminHomePage.routeName:(context)=>AdminHomePage(),
  EmployeeHomePage.routeName:(context)=>EmployeeHomePage(),
  OrderDeliveryPage.routeName:(context) => OrderDeliveryPage(),
  DaliyExpensesPage.routeName:(context) => DaliyExpensesPage(),
  AttendancePage.routeName:(context) => AttendancePage(),
  PaymentOrderPage.routeName:(context) => PaymentOrderPage(),
};
