import 'package:flutter/material.dart';
import 'package:rentapp/globals.dart';
import 'package:rentapp/size_config.dart';

class TotalSalesPage extends StatefulWidget {
  const TotalSalesPage({super.key});

  static String routeName = '/totalsales';

  @override
  State<TotalSalesPage> createState() => _TotalSalesPageState();
}

class _TotalSalesPageState extends State<TotalSalesPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.only(
            left: SizeConfig.screenWidth * 0.0233,
            right: SizeConfig.screenWidth * 0.0233,
            top: SizeConfig.screenWidth * 0.00456,
            bottom: SizeConfig.screenWidth * 0.00456),
        child: Column(children: [
          ...Sales.map((e) => Card(
                color: Colors.blue.shade100,
                child: ListTile(
                  isThreeLine: true,
                  title: Text(
                    e["hospital"],
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.042,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invoice No. ${e["invoice"]}",
                        style: TextStyle(
                            fontSize: SizeConfig.screenWidth * 0.042,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        e["date"],
                        style: TextStyle(
                            fontSize: SizeConfig.screenWidth * 0.042,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  trailing: Column(children: [
                    Text(
                      "Rs.${e["amount"]}.00",
                      style: TextStyle(
                          fontSize: SizeConfig.screenWidth * 0.042,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    // SizedBox(height: width *0.0233,),
                    (e["status"] == "Pending")
                        ? Container(
                            alignment: Alignment.center,
                            height: SizeConfig.screenWidth * 0.08,
                            width: SizeConfig.screenWidth * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.screenWidth * 0.02),
                                color: Colors.red),
                            child: Center(
                              child: Text(
                                "Pending",
                                style: TextStyle(
                                    fontSize: SizeConfig.screenWidth * 0.042,
                                    // letterSpacing: 2,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            height: SizeConfig.screenWidth * 0.08,
                            width: SizeConfig.screenWidth * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.screenWidth * 0.02),
                                color: Colors.green),
                            child: Text(
                              "Received",
                              style: TextStyle(
                                fontSize: SizeConfig.screenWidth * 0.042,
                                // letterSpacing: 2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                  ]),
                ),
              ))
        ]),
      ),
    );
  }
}
