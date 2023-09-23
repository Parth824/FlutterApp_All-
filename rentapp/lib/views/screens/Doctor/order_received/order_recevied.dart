import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentapp/size_config.dart';
import 'package:rentapp/views/screens/Doctor/complain/cir_contoroller.dart';

import '../../../../globals.dart';
import '../../../../main.dart';
import 'order_received_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderReceivedPage extends StatefulWidget {
  const OrderReceivedPage({super.key});

  static String routeName = '/order_received';

  @override
  State<OrderReceivedPage> createState() => _OrderReceivedPageState();
}

class _OrderReceivedPageState extends State<OrderReceivedPage> {
  OrderReceivedController orderReceivedController =
      Get.put(OrderReceivedController());
  CirController cirController = Get.put(CirController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Order Received",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.all(
          getProportionateScreenHeight(10),
        ),
        child: FutureBuilder(
          future: orderReceivedController
              .getDataApi(k: {"Id": '${sharedPreferences.getString("Id")}'}),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData) {
              return Obx(
                () => (orderReceivedController.data.isEmpty)
                    ? Center(
                        child: Image.asset("assets/images/no-data.png"),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: orderReceivedController.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(2, 2),
                                      color: Colors.black26,
                                    ),
                                  ],
                                  color: Color(0xffB3E6FF),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      getProportionateScreenHeight(10),
                                    ),
                                  ),
                                ),
                                height: SizeConfig.screenHeight * 0.0847,
                                width: SizeConfig.screenWidth,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(
                                                getProportionateScreenHeight(
                                                    10)),
                                            topLeft: Radius.circular(
                                              getProportionateScreenHeight(10),
                                            ),
                                          ),
                                          child: Container(
                                            color: Colors.blue,
                                            child: Center(
                                              child: Text(
                                                  "Invoice ${orderReceivedController.data[index]['O_Id']}"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Center(
                                            child: Text(
                                              "${orderReceivedController.data[index]['Printer_Name']}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          15),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              "${orderReceivedController.data[index]['Amount']}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          14),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              cirController.setLoding(
                                                  isl: true);
                                              await orderReceivedController
                                                  .setConfirm(k: {
                                                'O_Id':
                                                    '${orderReceivedController.data[index]['O_Id']}',
                                                'D_Id':
                                                    '${sharedPreferences.getString("Id")}'
                                              });
                                              cirController.setLoding(
                                                  isl: false);
                                              setState(() {});
                                            },
                                            child: Center(
                                                child: (cirController
                                                        .isloding.value)
                                                    ? CircularProgressIndicator()
                                                    : Text("Confirm")),
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.green),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(12),
                              ),
                            ],
                          );
                        },
                      ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
