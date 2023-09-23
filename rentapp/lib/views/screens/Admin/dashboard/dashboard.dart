import 'package:flutter/material.dart';

import '../../../../globals.dart';
import '../../../../size_config.dart';
import 'dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static String routeName = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashBoardController dashBoardController = Get.put(DashBoardController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    await dashBoardController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.only(
            top: getProportionateScreenHeight(10),
            bottom: getProportionateScreenHeight(10),
            left: getProportionateScreenWidth(10),
            right: getProportionateScreenWidth(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(getProportionateScreenHeight(10)),
                  decoration: BoxDecoration(
                      color: Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(10)),
                  height: SizeConfig.screenHeight / 4.7,
                  width: SizeConfig.screenWidth / 2.20,
                  child: Center(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (dashBoardController.dashBoard.value.isNotEmpty)
                              ? Text(
                                  "${dashBoardController.dashBoard[0]['Total_Doctor']}",
                                  style: TextStyle(
                                      color: Color(0xff223263),
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          getProportionateScreenHeight(50)),
                                )
                              : CircularProgressIndicator(),
                          Text(
                            "TOTAL \nDOCTOR",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenHeight(18)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.01,
                ),
                Container(
                  padding: EdgeInsets.all(getProportionateScreenHeight(10)),
                  decoration: BoxDecoration(
                      color: Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(10)),
                  height: SizeConfig.screenHeight / 4.7,
                  width: SizeConfig.screenWidth / 2.20,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "53",
                          style: TextStyle(
                              color: Color(0xff223263),
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenHeight(50)),
                        ),
                        Container(
                          child: Text(
                            "TOTAL \nEMPLOYEE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenHeight(18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight / 80,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffD9D9D9),
                borderRadius: BorderRadius.circular(
                  getProportionateScreenHeight(10),
                ),
              ),
              height: SizeConfig.screenHeight / 4.7,
              width: SizeConfig.screenWidth,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "5,46,432",
                      style: TextStyle(
                          color: Color(0xff223263),
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenHeight(50)),
                    ),
                    Text(
                      "TOTAL SALES",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenHeight(20)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
