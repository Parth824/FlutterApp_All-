import 'package:flutter/material.dart';
import 'package:rentapp/views/screens/Admin/addprinters/addprinter_alert.dart';

import '../../../../globals.dart';
import '../../../../size_config.dart';
import '../expense/add_expense_alert.dart';

class AddPrinterPage extends StatefulWidget {
  const AddPrinterPage({super.key});

  static String routeName = '/additems';

  @override
  State<AddPrinterPage> createState() => _AddPrinterPageState();
}

class _AddPrinterPageState extends State<AddPrinterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: ListView.builder(
            padding: EdgeInsets.only(
              top: getProportionateScreenHeight(15),
            ),
            itemCount: Items.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Image.network(
                              Items[i]['image'],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: SizeConfig.screenHeight * 0.13,
                      width: SizeConfig.screenWidth * 0.95,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(1, 1),
                              color: Colors.black54,
                              blurRadius: 7),
                          BoxShadow(
                              offset: Offset(-1, -1),
                              color: Colors.white54,
                              blurRadius: 7),
                        ],
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenHeight(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                getProportionateScreenHeight(10),
                              ),
                              topLeft: Radius.circular(
                                getProportionateScreenHeight(10),
                              ),
                            ),
                            child: Container(
                              height: SizeConfig.screenHeight * 0.13,
                              width: SizeConfig.screenWidth * 0.3,
                              color: Colors.blue,
                              child: Image.network(
                                Items[i]['image'],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(15),
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.32,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    Items[i]['printer_name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: SizeConfig.screenHeight * 0.022,
                                    ),
                                  ),
                                  Text(
                                    "Quantity : ${Items[i]['stock']}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: SizeConfig.screenHeight * 0.02,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            Items[i]['price'],
                            style: TextStyle(
                                fontSize: SizeConfig.screenHeight * 0.025,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add Item"),
        tooltip: "Add Item",
        onPressed: () {
          showDialog(context: context, builder: (context) {
            return AlertItems();
          },);
        },
      ),
    );
  }
}
