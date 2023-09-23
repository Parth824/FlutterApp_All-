import 'package:flutter/material.dart';
import 'package:rentapp/size_config.dart';
import 'package:rentapp/views/screens/Admin/payments/add_payments_alert.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  static String routeName = '/payments';

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  List<Map<String, dynamic>> Invoice = [
    {
      "date": "03-jan",
      "Bank Account": "BANDHAN BANK",
      "Contact": "Shah Hospital",
      "Amount": "20000",
    },
    {
      "date": "31-may",
      "Bank Account": "CASH",
      "Contact": "Patel Hospital",
      "Amount": "30000",
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.only(top: getProportionateScreenHeight(10), bottom: getProportionateScreenHeight(10), left: getProportionateScreenHeight(2), right: getProportionateScreenHeight(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: SizeConfig.screenHeight * 0.05,
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Text(
                        "Date",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(14),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Bank Account",
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(14),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Contact",
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(14),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Amount",
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(14),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * .01,
            ),
            ...Invoice.map(
              (e) => Container(
                alignment: Alignment.center,
                // height: SizeConfig.screenHeight * 0.04,
                width: SizeConfig.screenWidth,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            e["date"],
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                                fontSize: getProportionateScreenHeight(14),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            e["Bank Account"],
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                                fontSize: getProportionateScreenHeight(14),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            e["Contact"],
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                                fontSize: getProportionateScreenHeight(14),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            e["Amount"],
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                                fontSize: getProportionateScreenHeight(15),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      indent: 5,
                      endIndent: 5,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddPaymentsAlert();
            },
          );
        },
        child: Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
