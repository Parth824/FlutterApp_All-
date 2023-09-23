import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rentapp/globals.dart';
import 'package:rentapp/size_config.dart';



class PDFpage extends StatefulWidget {
  const PDFpage({super.key});

  @override
  State<PDFpage> createState() => _PDFpageState();
}

class _PDFpageState extends State<PDFpage> {
  
  final pdf = pw.Document();
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
             SizeConfig.screenWidth * 0.025,
          ),
          height:  SizeConfig.screenHeight,
          width:  SizeConfig.screenWidth,
          color: PdfColors.white,
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Container(
                  alignment: pw.Alignment.center,
                  height:  SizeConfig.screenHeight * 0.025,
                  width:  SizeConfig.screenWidth,
                  child: pw.Text(
                    "Ledger",
                    style: pw.TextStyle(
                        fontSize:  SizeConfig.screenWidth*0.42, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Container(
                  alignment: pw.Alignment.center,
                  height:  SizeConfig.screenHeight * 0.025,
                  width:  SizeConfig.screenWidth,
                  child: pw.Text(
                    "UD Service",
                    style: pw.TextStyle(
                        fontSize: SizeConfig.screenWidth *0.06, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.Container(
                  padding: pw.EdgeInsets.only(left: SizeConfig.screenWidth *0.01, right:  SizeConfig.screenWidth * 0.01),
                  alignment: pw.Alignment.center,
                  height:  SizeConfig.screenHeight * 0.135,
                  width:  SizeConfig.screenWidth,
                  child: pw.Column(
                    children: [
                      pw.Text(
                        "SHOPNO. 212 RAJ GALAXY COMPLEX, NR. STUTI HIGH LAND  ",
                        style: pw.TextStyle(
                            fontSize:  SizeConfig.screenWidth * 0.028, fontWeight: pw.FontWeight.normal),
                      ),
                      pw.Text(
                        " PALANPOR JAKATNAKA GAM, SURAT, GUJARAT:395009.",
                        style: pw.TextStyle(
                            fontSize:  SizeConfig.screenWidth * 0.028, fontWeight: pw.FontWeight.normal),
                      ),
                      pw.Text(
                        "Contact No. : 7990556886 , Email: mohit.udservices@gmail.com",
                        style: pw.TextStyle(
                            fontSize:  SizeConfig.screenWidth * 0.028, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Divider(
                        color: PdfColors.black,
                      ),
                      pw.Text(
                        "Surat Imagine Center",
                        style: pw.TextStyle(
                            fontSize:  SizeConfig.screenWidth * 0.042, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.Text(
                        "SHOPNO. 212 RAJ GALAXY COMPLEX, NR. STUTI HIGH LAND ",
                        style: pw.TextStyle(
                            fontSize:  SizeConfig.screenWidth * 0.028, fontWeight: pw.FontWeight.normal),
                      ),
                      pw.Text(
                        " PALANPOR JAKATNAKA GAM, SURAT, GUJARAT:395009.",
                        style: pw.TextStyle(
                            fontSize:  SizeConfig.screenWidth * 0.028, fontWeight: pw.FontWeight.normal),
                      ),
                      pw.Text(
                        "From 01-01-2022 to 01-01-2023",
                        style: pw.TextStyle(
                            fontSize:  SizeConfig.screenWidth * 0.042, fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  height:  SizeConfig.screenHeight * 0.05,
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
                                fontSize:  SizeConfig.screenWidth * 0.042, fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          child: pw.Text(
                            "Details",
                            style: pw.TextStyle(
                                fontSize: SizeConfig.screenWidth * 0.042, fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          "Voucher",
                          style: pw.TextStyle(
                              fontSize:  SizeConfig.screenWidth * 0.042, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "Debit",
                          style: pw.TextStyle(
                              fontSize:  SizeConfig.screenWidth * 0.042, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "Credit",
                          style: pw.TextStyle(
                              fontSize:  SizeConfig.screenWidth * 0.042, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                ...pdfdetails1.map(
                  (e) => pw.Container(
                    alignment: pw.Alignment.center,
                    height:  SizeConfig.screenHeight * 0.04,
                    width:  SizeConfig.screenWidth,
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text(
                            e["date"],
                            style: pw.TextStyle(
                                fontSize:  SizeConfig.screenWidth * 0.037, fontWeight: pw.FontWeight.normal),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            e["type"],
                            style: pw.TextStyle(
                                fontSize:  SizeConfig.screenWidth * 0.037, fontWeight: pw.FontWeight.normal),
                          ),
                        ),
                        pw.Expanded(
                          flex: 3,
                          child: pw.Text(
                            e["voucher"],
                            style: pw.TextStyle(
                                fontSize:  SizeConfig.screenWidth * 0.037, fontWeight: pw.FontWeight.normal),
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text(
                            e["debit"],
                            style: pw.TextStyle(
                                fontSize:  SizeConfig.screenWidth * 0.037, fontWeight: pw.FontWeight.normal),
                          ),
                        ),
                        pw.Expanded(flex: 2, child: pw.Text(e["credit"])),
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
                      width:  SizeConfig.screenWidth * 0.2,
                    ),
                    pw.Text(
                      "Closing Balance :",
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize:  SizeConfig.screenWidth * 0.042),
                    ),
                    pw.Text("200000",
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize:  SizeConfig.screenWidth * 0.037)),
                    pw.Text("20000",
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize:  SizeConfig.screenWidth * 0.037)),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text("00",
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize:  SizeConfig.screenWidth * 0.037)),
                    pw.SizedBox(
                      width:  SizeConfig.screenWidth * 0.04,
                    ),
                    pw.Text("180000",
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize:  SizeConfig.screenWidth * 0.037)),
                  ],
                ),
                pw.Divider(
                  thickness: 2,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.SizedBox(
                      width:  SizeConfig.screenWidth * 0.22,
                    ),
                    pw.Text(
                      "Closing Balance :",
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize:  SizeConfig.screenWidth * 0.042),
                    ),
                    pw.Text("200000",
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize:  SizeConfig.screenWidth*0.037)),
                    pw.Text("200000",
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize:  SizeConfig.screenWidth * 0.037)),
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: Text("Ledger"),),
      body: Container(
        height: SizeConfig.screenHeight,
        width:  SizeConfig.screenWidth,
        padding: EdgeInsets.only(top:  SizeConfig.screenWidth * 0.0233, bottom:  SizeConfig.screenWidth * 0.0233, left:  SizeConfig.screenWidth * 0.00456, right:  SizeConfig.screenWidth*0.00456),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig.screenHeight * 0.08,
                width:  SizeConfig.screenWidth,
                decoration: BoxDecoration(color: Colors.blue.shade300),
                child: Row(children: [
                  Icon(
                    Icons.filter_alt,
                    size:  SizeConfig.screenWidth * 0.093,
                  ),
                  SizedBox(
                    width:  SizeConfig.screenWidth * 0.02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Duration",
                        style: TextStyle(
                            fontSize:  SizeConfig.screenWidth * 0.037, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            "9 jun 2022 - Today",
                            style: TextStyle(
                                fontSize:  SizeConfig.screenWidth * 0.0325, fontWeight: FontWeight.w600),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width:  SizeConfig.screenWidth * 0.4,
                  ),
                  GestureDetector(
                      onTap: () async {
                        Uint8List data = await pdf.save();
                        await Printing.layoutPdf(onLayout: (format) => data);
                      },
                      child: Icon(
                        Icons.picture_as_pdf,
                        size:  SizeConfig.screenWidth * 0.081,
                      ))
                ]),
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
                              fontSize:  SizeConfig.screenWidth * 0.042, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(
                          "Details",
                          style: TextStyle(
                              fontSize:  SizeConfig.screenWidth * 0.042, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Voucher",
                        style: TextStyle(
                            fontSize:  SizeConfig.screenWidth * 0.042, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Debit",
                        style: TextStyle(
                            fontSize:  SizeConfig.screenWidth * 0.042, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Credit",
                        style: TextStyle(
                            fontSize:  SizeConfig.screenWidth*0.042, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              ...pdfdetails.map(
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
                              fontSize:  SizeConfig.screenWidth * 0.037, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          e["type"],
                          style: TextStyle(
                              fontSize:  SizeConfig.screenWidth * 0.037, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          e["voucher"],
                          style: TextStyle(
                              fontSize:  SizeConfig.screenWidth * 0.037, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          e["debit"],
                          style: TextStyle(
                              fontSize:  SizeConfig.screenWidth * 0.037,
                              fontWeight: FontWeight.w400,
                              color: Colors.red),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            e["credit"],
                            style: TextStyle(
                                fontSize:  SizeConfig.screenWidth * 0.037, color: Colors.green),
                          )),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness:  SizeConfig.screenWidth *0.00456,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width:  SizeConfig.screenWidth * 0.2,
                  ),
                  Text(
                    "Closing Balance :",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize:  SizeConfig.screenWidth * 0.042),
                  ),
                  Text("200000",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize:  SizeConfig.screenWidth * 0.037)),
                  Text("20000",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize:  SizeConfig.screenWidth * 0.037)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("00",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize:  SizeConfig.screenWidth * 0.037)),
                  SizedBox(
                    width:  SizeConfig.screenWidth * 0.04,
                  ),
                  Text("180000",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize:  SizeConfig.screenWidth * 0.037)),
                ],
              ),
              Divider(
                thickness:  SizeConfig.screenWidth *0.00456,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width:  SizeConfig.screenWidth * 0.38,
                  ),
                  Text(
                    " Balance :",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize:  SizeConfig.screenWidth * 0.042),
                  ),
                  Text("200000",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize:  SizeConfig.screenWidth * 0.037)),
                  Text("200000",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize:  SizeConfig.screenWidth * 0.037)),
                ],
              ),
            ]),
      ),
    );
  }
}
