import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:get/get.dart';
import 'package:rentapp/main.dart';

import '../../../../globals.dart';
import 'balance_controller.dart';
import 'ledger_controller.dart';

class LedgerPage extends StatefulWidget {
  const LedgerPage({super.key});

  static String routeName = '/ledger';

  @override
  State<LedgerPage> createState() => _LedgerPageState();
}

class _LedgerPageState extends State<LedgerPage> {
  final pdf = pw.Document();
  LedgerContorller ledgerContorller = Get.put(LedgerContorller());
  @override
  void initState() {
    super.initState();
    makepdf();
  }

  makepdf() {
    pdf.addPage(
      pw.Page(
        build: (pw.Context context1) => pw.Container(
          padding: pw.EdgeInsets.all(
            MediaQuery.of(context).size.width * 0.025,
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: PdfColors.white,
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Container(
                  alignment: pw.Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.025,
                  width: MediaQuery.of(context).size.width,
                  child: pw.Text(
                    "Ledger",
                    style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Container(
                  alignment: pw.Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.025,
                  width: MediaQuery.of(context).size.width,
                  child: pw.Text(
                    "UD Service",
                    style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Container(
                  padding: pw.EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                      right: MediaQuery.of(context).size.width * 0.01),
                  alignment: pw.Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.135,
                  width: MediaQuery.of(context).size.width,
                  child: pw.Column(
                    children: [
                      pw.Text(
                        "SHOPNO. 212 RAJ GALAXY COMPLEX, NR. STUTI HIGH LAND  ",
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.028,
                            fontWeight: pw.FontWeight.normal),
                      ),
                      pw.Text(
                        " PALANPOR JAKATNAKA GAM, SURAT, GUJARAT:395009.",
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.028,
                            fontWeight: pw.FontWeight.normal),
                      ),
                      pw.Text(
                        "Contact No. : 7990556886 , Email: mohit.udservices@gmail.com",
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.028,
                            fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Divider(
                        color: PdfColors.black,
                      ),
                      pw.Text(
                        "Surat Imagine Center",
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.042,
                            fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        "SHOPNO. 212 RAJ GALAXY COMPLEX, NR. STUTI HIGH LAND ",
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.028,
                            fontWeight: pw.FontWeight.normal),
                      ),
                      pw.Text(
                        " PALANPOR JAKATNAKA GAM, SURAT, GUJARAT:395009.",
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.028,
                            fontWeight: pw.FontWeight.normal),
                      ),
                      pw.Text(
                        "From 01-01-2022 to 01-01-2023",
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.042,
                            fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: pw.BoxDecoration(color: PdfColors.grey200),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          color: PdfColors.grey300,
                          child: pw.Text(
                            "Date",
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.042,
                                fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          child: pw.Text(
                            "Details",
                            style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.042,
                                fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          "Voucher",
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.042,
                              fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "Debit",
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.042,
                              fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "Credit",
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.042,
                              fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                ...ledgerContorller.Data.map(
                  (e) => pw.Container(
                    alignment: pw.Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width,
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text(
                            e["O_Date"],
                            style: pw.TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.037,
                                fontWeight: pw.FontWeight.normal),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            e["Payment_Transfer_Name"],
                            style: pw.TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.037,
                                fontWeight: pw.FontWeight.normal),
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text(
                            "Invoice-${e["O_Id"]}",
                            style: pw.TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.037,
                                fontWeight: pw.FontWeight.normal),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: (e['Payment_Type'] == 'Pending')?pw.Text(
                            e["Amount"],
                            style: pw.TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.037,
                                fontWeight: pw.FontWeight.normal),
                          ):pw.Text(
                            " ",
                            style: pw.TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.037,
                                fontWeight: pw.FontWeight.normal),
                          )
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: (e['Payment_Type'] == 'Receiving')?pw.Text(
                            e["Amount"],
                          ):pw.Text(
                            " ",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.Divider(
                  thickness: 2,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    pw.Text(
                      "Closing Balance :",
                      style: pw.TextStyle(
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.042),
                    ),
                    pw.Text("${ledgerContorller.debit}",
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.037)),
                    pw.Text("${ledgerContorller.credit}",
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.037)),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text("${(ledgerContorller.credit.value + ledgerContorller.debit.value) - ledgerContorller.debit.value}",
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.037)),
                    pw.SizedBox(
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    pw.Text("${(ledgerContorller.credit.value + ledgerContorller.debit.value) - ledgerContorller.credit.value}",
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.037)),
                    pw.SizedBox(
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ],
                ),
                pw.Divider(
                  thickness: 2,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.SizedBox(
                      width: MediaQuery.of(context).size.width * 0.22,
                    ),
                    pw.Text(
                      "Closing Balance :",
                      style: pw.TextStyle(
                          color: PdfColors.black,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.042),
                    ),
                    pw.Text("${ledgerContorller.credit.value + ledgerContorller.debit.value}",
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.037)),
                    pw.Text("${ledgerContorller.credit.value + ledgerContorller.debit.value}",
                        style: pw.TextStyle(
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.037)),
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Ledger",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: height,
        width: width,
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
              height: height * 0.08,
              width: width,
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
                          width: width * 0.02,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Duration",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.037,
                                  fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Text(
                                  "9 jun 2022 - Today",
                                  style: TextStyle(
                                      color: Colors.black,
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
                  Container(
                    child: Row(
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
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Container(
              height: height * 0.05,
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
                            color: Colors.black,
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
                            color: Colors.black,
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
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.042,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Debit",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.042,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Credit",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * 0.042,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: ledgerContorller.getApiData(
                  k: {"Id": '${sharedPreferences.getString("Id")}'}),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  return Obx(
                    () => (ledgerContorller.Data.isEmpty)
                        ? Center(
                            child: Image.asset("assets/images/no-data.png"))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: ledgerContorller.Data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                alignment: Alignment.center,
                                height: height * 0.04,
                                width: width,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        ledgerContorller.Data[index]["O_Date"],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.037,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        ledgerContorller.Data[index]
                                            ["Payment_Transfer_Name"],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.037,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Invoice-${ledgerContorller.Data[index]["O_Id"]}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.037,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: (ledgerContorller.Data[index]
                                                  ['Payment_Type'] ==
                                              'Pending')
                                          ? Text(
                                              ledgerContorller.Data[index]
                                                  ["Amount"],
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.037,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.red),
                                            )
                                          : Text(
                                              " ",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.037,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.red),
                                            ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: (ledgerContorller.Data[index]
                                                  ['Payment_Type'] ==
                                              'Receiving')
                                          ? Text(
                                              ledgerContorller.Data[index]
                                                  ["Amount"],
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.037,
                                                  color: Colors.green),
                                            )
                                          : Text(
                                              " ",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.037,
                                                  color: Colors.green),
                                            ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            Divider(
              thickness: width * 0.00456,
            ),
            Obx(
              () {
                ledgerContorller.credit.value = 0;
                ledgerContorller.debit.value = 0;
                for (int i = 0; i < ledgerContorller.Data.length; i++) {
                  ledgerContorller.getAmount(
                      k: int.parse(ledgerContorller.Data[i]["Amount"]),
                      py: ledgerContorller.Data[i]["Payment_Type"]);
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("${ledgerContorller.debit}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.037)),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          "${ledgerContorller.credit}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.037),
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: width * 0.2,
                        ),
                        Text(
                          "Closing Balance :",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.042),
                        ),
                        Text(
                            "${(ledgerContorller.credit.value + ledgerContorller.debit.value) - ledgerContorller.debit.value}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.037)),
                        Text(
                            "${(ledgerContorller.credit.value + ledgerContorller.debit.value) - ledgerContorller.credit.value}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.037)),
                      ],
                    ),
                    Divider(
                      thickness: width * 0.00456,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: width * 0.38,
                        ),
                        Text(
                          "Balance :",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.042),
                        ),
                        Text(
                          "${ledgerContorller.credit.value + ledgerContorller.debit.value}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.037),
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        Text(
                          "${ledgerContorller.credit.value + ledgerContorller.debit.value}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.037),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
