import 'package:flutter/material.dart';
import 'package:rentapp/globals.dart';
import 'package:rentapp/size_config.dart';
import 'package:rentapp/views/screens/Admin/bankaccount/add_bank_account.dart';

class BankAccountPage extends StatefulWidget {
  const BankAccountPage({super.key});

  static String routeName = '/bankaccount';

  @override
  State<BankAccountPage> createState() => _BankAccountPageState();
}

class _BankAccountPageState extends State<BankAccountPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(SizeConfig.screenWidth / 100),
          ),
          ...Invoice4.map(
            (e) => Container(
              height: SizeConfig.screenHeight / 10,
              child: Card(
                color: const Color(0xffB3E6FF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: SizeConfig.screenWidth / 20,
                    ),
                    Image(
                      image: AssetImage(
                        e["photo"],
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.screenWidth / 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e["name"],
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.screenHeight / 40),
                        ),
                        Text(
                          e["price"],
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.screenHeight / 50),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Add_Bank_Account();
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Bank Account"),
      ),
    );
  }
}
