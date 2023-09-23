import 'package:flutter/material.dart';

import '../../../../globals.dart';
import '../../../../main.dart';
import '../../../../size_config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'payment_due_contorller.dart';

class PaymentDuePage extends StatefulWidget {
  const PaymentDuePage({super.key});

  static String routeName = '/paymentdue';

  @override
  State<PaymentDuePage> createState() => _PaymentDuePageState();
}

class _PaymentDuePageState extends State<PaymentDuePage> {
  PaymentDueContoroller paymentDueContoroller =
      Get.put(PaymentDueContoroller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    String? k = sharedPreferences.getString("Id");
    await paymentDueContoroller.getPayment(k: {"Id": k});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Payment Due",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: SizeConfig.screenHeight * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "    Party Name",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(16),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "   Invoice No.",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(16),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "  Amount",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(16),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "  Status",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(16),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 5,
                ),
                Obx(() => paymentDueContoroller.data.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      shrinkWrap: true,
                      itemCount: paymentDueContoroller.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration:
                                    BoxDecoration(color: Colors.red.shade200),
                                height: SizeConfig.screenHeight * 0.05,
                                width: SizeConfig.screenWidth,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: Text(
                                            paymentDueContoroller.data[index]["First_Name"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        15),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Text(
                                          paymentDueContoroller.data[index]["O_Id"],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      15),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(
                                            paymentDueContoroller.data[index]["Amount"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        16),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(
                                            paymentDueContoroller.data[index]["O_Date"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        12),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        },
                      )),
                // ListTile(title: Text("Akash"),leading: Text("1"),trailing: Container(color: Colors.green,child: Text("Received")),subtitle: Text("20000"),)
                // ...Invoice.map((e) => Card(
                //       elevation: 3,
                //       child: ListTile(
                //         title: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [Text(e["name"],
                //                 style: TextStyle(
                //                     fontWeight: FontWeight.w500, fontSize: 18),
                //               ),
                //           // Text("Amount. ${e["Amount"]}")
                //         ]),
                //         leading: Text(e["Invoice"],
                //           style: TextStyle(
                //               fontWeight: FontWeight.w500, fontSize: 18),
                //         ),
                //         trailing:
                //         (e["status"] == true)
                //             ? Container(
                //               padding: EdgeInsets.all(4),
                //               height: height*0.03,
                //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                //                   color: Colors.green,
                //                 ),
                //               // alignment: Alignment.center,
                //                  child: Text("Received",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),))
                //             :
                //              Container(
                //               padding: EdgeInsets.all(4),
                //               height: height*0.03,
                //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                //                   color: Colors.red,
                //                 ),
                //               // alignment: Alignment.center,
                //                  child: Text("Pending",style: TextStyle(),)),
                //         subtitle: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             Text("Rs:${e["Amount"]}",style:TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                //             Text("Dt:${e["date"]}"),
                //           ],
                //         ),
                //       ),
                //     ))
              ]),
        ),
      ),
    );
  }
}
