import 'package:flutter/material.dart';

import '../../../../size_config.dart';
import 'onlinepayment.dart';

class PaymentOrderPage extends StatefulWidget {
  const PaymentOrderPage({super.key});

  static String routeName = "/paymentorderpage";
  @override
  State<PaymentOrderPage> createState() => _PaymentOrderPageState();
}

class _PaymentOrderPageState extends State<PaymentOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payments"),
      ),
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
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: SizeConfig.screenHeight / 6.5,
                    width: SizeConfig.screenWidth * 0.45,
                    child: Center(
                      child: Text(
                        "COD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenHeight(30),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.01,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: SizeConfig.screenHeight / 6.5,
                    width: SizeConfig.screenWidth * 0.45,
                    child: Center(
                      child: Text(
                        "Pending",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenHeight(30),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.screenHeight / 80,
            ),
            GestureDetector(
              onTap: () async {
                try {
                   Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OnlinePaymentPage(),
                    ),
                  );

                } catch (e) {}
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: SizeConfig.screenHeight / 6.5,
                child: Center(
                  child: Text(
                    "Online Payment",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenHeight(30),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
