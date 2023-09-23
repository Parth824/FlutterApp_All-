import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rentapp/views/screens/Doctor/complain/complain.dart';
import 'package:rentapp/views/screens/Doctor/ledger/ledger.dart';
import 'package:rentapp/views/screens/Doctor/order/order_page.dart';
import 'package:rentapp/views/screens/Doctor/order_received/order_recevied.dart';
import 'package:rentapp/views/screens/Doctor/payment/payment.dart';
import 'package:rentapp/views/screens/Doctor/payment_due/payment_due.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../../size_config.dart';
import '../../LoginScreens/signin/sign_in_screen.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  static String routeName = "/doctorhomepage";

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          leading: Container(),
          title: Text(
            "Doctor Name",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            GestureDetector(
                onTap: () async {
                  await sharedPreferences.setBool("isLogin", false);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      SigniInScreen.routeName, (route) => false);
                },
                child: Icon(Icons.logout)),
            SizedBox(
              width: SizeConfig.screenWidth * 0.04,
            ),
          ],
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              // margin: EdgeInsets.all(MediaQuery.of(context).size.height*.02),
              margin: EdgeInsets.all(getProportionateScreenHeight(10)),
              height: SizeConfig.screenHeight * .24,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenHeight * .027),
                color: Colors.blue,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "750+",
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(50),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Happy Customers",
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(25),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * .03,
            ),
            Expanded(
              flex: 6,
              child: Container(
                // color: Theme.of(context).primaryColor,
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenHeight(30)),
                    decoration: BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(getProportionateScreenHeight(100)),
                      ),
                    ),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: SizeConfig.screenWidth * .12,
                      mainAxisSpacing: SizeConfig.screenHeight * .02,
                      children: [
                        itmeDashbord(
                            "Order", "assets/icons/Cart Icon.svg", Colors.blue,
                            () {
                          Navigator.pushNamed(context, Order_Page.routeName);
                        }),
                        itmeDashbord("Payment\n Due", "assets/icons/Cash.svg",
                            Colors.red, () {
                          Navigator.pushNamed(
                              context, PaymentDuePage.routeName);
                        }),
                        itmeDashbord(
                            "Ledgar", "assets/icons/ledger.svg", Colors.blue,
                            () {
                          Navigator.pushNamed(context, LedgerPage.routeName);
                        }),
                        itmeDashbord(
                            "Payment", "assets/icons/Cash.svg", Colors.green,
                            () {
                          Navigator.pushNamed(context, PaymentPage.routeName);
                        }),
                        itmeDashbord("Complain", "assets/icons/complain.svg",
                            Colors.blue, () {
                          Navigator.pushNamed(context, ComplainPage.routeName);
                        }),
                        itmeDashbord("Order\n Received",
                            "assets/icons/order_recieved.svg", Colors.blue, () {
                          Navigator.pushNamed(
                              context, OrderReceivedPage.routeName);
                        }),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  itmeDashbord(
      String title, String svgimage, Color color, GestureTapCallback press) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(getProportionateScreenHeight(10)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenHeight(10)),
              height: SizeConfig.screenHeight * .08,
              width: SizeConfig.screenWidth * .18,
              decoration: BoxDecoration(
                  // color: color,
                  // shape: BoxShape.circle,
                  ),
              child: SvgPicture.asset(
                svgimage,
                color: color,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * .01),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
