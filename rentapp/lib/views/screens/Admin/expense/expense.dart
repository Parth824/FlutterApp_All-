import 'package:flutter/material.dart';
import 'package:rentapp/globals.dart';
import 'package:rentapp/size_config.dart';
import 'package:rentapp/views/screens/Admin/expense/add_expense_alert.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  static String routeName = '/expense';

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: ListView.builder(
            padding: EdgeInsets.only(
              top: getProportionateScreenHeight(15),
            ),
            itemCount: Expense.length,
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
                              Expense[i]['bill'],
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
                              blurRadius: 7,),
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
                                Expense[i]['bill'],
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
                                    Expense[i]['emp_name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: SizeConfig.screenHeight * 0.022,
                                    ),
                                  ),
                                  Text(
                                    Expense[i]['category'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: SizeConfig.screenHeight * 0.02,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  Text(
                                    Expense[i]['date'],
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
                            Expense[i]['amount'],
                            style: TextStyle(
                                fontSize: SizeConfig.screenHeight * 0.025,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(10),
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
        label: Text("Add Expense"),
        tooltip: "Add Expense",
        onPressed: () {
          showDialog(context: context, builder: (context) {
            return AlertDialogExpense();
          },);
        },
      ),
    );
  }
}
