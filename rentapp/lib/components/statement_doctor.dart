import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:rentapp/size_config.dart';
import 'package:pdf/widgets.dart' as pw;

import '../globals.dart';

class StatementDoctor extends StatefulWidget {
  const StatementDoctor({super.key});

  @override
  State<StatementDoctor> createState() => _StatementDoctorState();
}

class _StatementDoctorState extends State<StatementDoctor> {
  final pdf = pw.Document();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
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
              height: SizeConfig.screenHeight * 0.08,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(color: Colors.blue.shade300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_alt,
                          size: MediaQuery.of(context).size.width * 0.093,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.02,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Duration",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.037,
                                  fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Text(
                                  "9 jun 2022 - Today",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.0325,
                                      fontWeight: FontWeight.w600),
                                ),
                                Icon(Icons.arrow_drop_down)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () async {
                            Uint8List data = await pdf.save();
                            await Printing.layoutPdf(
                                onLayout: (format) => data);
                          },
                          child: Icon(
                            Icons.picture_as_pdf,
                            size: MediaQuery.of(context).size.width * 0.081,
                          )),
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.05,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),
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
                    flex: 2,
                    child: Container(
                      child: Text(
                        "Details",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.042,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Voucher",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.042,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Debit",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.042,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Credit",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.042,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            ...pdfdetails1.map(
              (e) => Container(
                alignment: Alignment.center,
                height: SizeConfig.screenHeight * 0.04,
                width: SizeConfig.screenWidth,
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
                      flex: 2,
                      child: Text(
                        e["type"],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.037,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        e["voucher"],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.037,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        e["debit"],
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.037,
                            fontWeight: FontWeight.w400,
                            color: Colors.red),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          e["credit"],
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.037,
                              color: Colors.green),
                        )),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: SizeConfig.screenWidth * 0.00456,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.2,
                ),
                Text(
                  "Closing Balance :",
                  style: TextStyle(
                    color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.width * 0.042),
                ),
                Text("200000",
                    style: TextStyle(
                      color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.width * 0.037)),
                Text("20000",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.width * 0.037)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("00",
                    style: TextStyle(
                      color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.width * 0.037)),
                SizedBox(
                  width: SizeConfig.screenWidth * 0.04,
                ),
                Text("180000",
                    style: TextStyle(
                      color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.width * 0.037)),
              ],
            ),
            Divider(
              thickness: SizeConfig.screenWidth * 0.00456,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.38,
                ),
                Text(
                  " Balance :",
                  style: TextStyle(
                    color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.width * 0.042),
                ),
                Text("200000",
                    style: TextStyle(
                      color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.width * 0.037)),
                Text("200000",
                    style: TextStyle(
                      color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.width * 0.037)),
              ],
            ),
          ]),
    );
  }
}
