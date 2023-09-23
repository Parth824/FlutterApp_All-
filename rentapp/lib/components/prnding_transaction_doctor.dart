import 'package:flutter/material.dart';
import 'package:rentapp/globals.dart';

import '../size_config.dart';

class PendingTransactionDoctor extends StatefulWidget {
  const PendingTransactionDoctor({super.key});

  @override
  State<PendingTransactionDoctor> createState() => _PendingTransactionDoctorState();
}

class _PendingTransactionDoctorState extends State<PendingTransactionDoctor> {
 @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight,
      width:  SizeConfig.screenWidth,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.0233,
          bottom: MediaQuery.of(context).size.width * 0.0233,
          left: MediaQuery.of(context).size.width * 0.00456,
          right: MediaQuery.of(context).size.width * 0.00456),
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
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.042,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Invoice No.",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.042,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Amount",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.042,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            ...Invoice5.map(
              (e) => Container(
                alignment: Alignment.center,
                height: SizeConfig.screenHeight * 0.04,
                width:  SizeConfig.screenWidth,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        e["date"],
                        style: TextStyle(
                          color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.037,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        e["Invoice"],
                        style: TextStyle(
                          color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.037,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        e["Amount"],
                        style: TextStyle(
                          color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.037,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: SizeConfig.screenHeight * 0.05,
              width:  SizeConfig.screenWidth,
              padding: EdgeInsets.only(left:  SizeConfig.screenWidth *0.0256),
              color: Colors.grey.shade300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Expanded(
                    flex: 6,
                    child: Text(
                      "Closing Amount:",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.037,
                          fontWeight: FontWeight.w600),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      "50000.00",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.037,
                          fontWeight: FontWeight.w600),
                    )),
              ]),
            )
          ]),
    );
  }
}