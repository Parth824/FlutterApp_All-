import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentapp/views/screens/Employee/dailyexpenses/expenses_data.dart';

List<Map<String, dynamic>> AllData = [];

class DaliyExpensesPage extends StatefulWidget {
  const DaliyExpensesPage({super.key});
  static String routeName = "/daliyexpenses";
  @override
  State<DaliyExpensesPage> createState() => _DaliyExpensesPageState();
}

class _DaliyExpensesPageState extends State<DaliyExpensesPage> {
  @override
  Widget build(BuildContext context) {
    // List data = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      
      body: (AllData.isNotEmpty)
          ? ListView.builder(
              itemCount: AllData.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Container(
                    // width: 200,
                    // height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date :  ",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text("Category :  ",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 3,
                              ),
                              Text("Contact :  ",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 3,
                              ),
                              Text("Amount :  ",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AllData[i]['date']}",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700]),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text("${AllData[i]['category']}",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[700])),
                              SizedBox(
                                height: 3,
                              ),
                              Text("${AllData[i]['number']}",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[700])),
                              SizedBox(
                                height: 3,
                              ),
                              Text("${AllData[i]['amount']}",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[700])),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/no-data.png",
                    height: 90,
                  ),
                  Text("No data found..."),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return ExpensesData();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
