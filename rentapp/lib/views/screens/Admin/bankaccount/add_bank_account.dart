import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:rentapp/globals.dart';
import 'package:rentapp/size_config.dart';

class Add_Bank_Account extends StatefulWidget {
  const Add_Bank_Account({super.key});

  @override
  State<Add_Bank_Account> createState() => _Add_Bank_AccountState();
}

class _Add_Bank_AccountState extends State<Add_Bank_Account> {
  int? number;
  int? amount;

  TextEditingController numberController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String dropdownvalue = 'Select type';

  var items = [
    'CASH',
    'BANK',
  ];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          "ADD BANK ACCOUNTS",
          style: TextStyle(fontSize: getProportionateScreenHeight(16)),
        ),
      ),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomSearchableDropDown(
                items: items,
                label: dropdownvalue,
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.screenHeight * 0.03),
                  border: Border.all(
                    
                  ),
                ),
                dropDownMenuItems: items.map((e) {
                  return e;
                }).toList(),
                dropdownBackgroundColor: Colors.white,
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                onChanged: (value) {
                  setState(() {
                    dropdownvalue = value;
                  });
                },
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              buildTextFormFieldEmployeeExpense(
                  text: "Bank Name", textInputAction: TextInputAction.next),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              buildTextFormFieldEmployeeExpense(
                  text: "opening Balance",
                  textInputAction: TextInputAction.next),
            ],
          ),
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Add",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  TextFormField buildTextFormFieldEmployeeExpense(
      {required TextInputAction textInputAction, required String text}) {
    return TextFormField(
      textInputAction: textInputAction,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.screenHeight * 0.03),
        ),
        hintText: text,
        hintStyle: TextStyle(),
        labelText: text,
        labelStyle: TextStyle(),
      ),
    );
  }
}
