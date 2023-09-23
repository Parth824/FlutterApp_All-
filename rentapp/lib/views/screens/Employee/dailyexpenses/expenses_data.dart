import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../size_config.dart';

class ExpensesData extends StatefulWidget {
  const ExpensesData({super.key});

  @override
  State<ExpensesData> createState() => _ExpensesDataState();
}

class _ExpensesDataState extends State<ExpensesData> {
  int? number;
  int? amount;

  String dropdownvalue = 'Travel';

  var items = [
    'Travel',
    'Food',
    'Nozzle Check',
    'Other',
  ];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          "Add Expense",
          style: TextStyle(),
        ),
      ),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _textEditingController,
                onTap: () async {
                  DateTime? newSelectedDate = await showDatePicker(
                    context: context,
                    initialDate:
                        _selectedDate != null ? _selectedDate! : DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2040),
                  );

                  if (newSelectedDate != null) {
                    _selectedDate = newSelectedDate;
                    _textEditingController
                      ..text = DateFormat.yMMMd().format(_selectedDate!)
                      ..selection = TextSelection.fromPosition(TextPosition(
                          offset: _textEditingController.text.length,
                          affinity: TextAffinity.upstream));
                  }
                },
                focusNode: AlwaysDisabledFocusNode(),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.screenHeight * 0.03),
                  ),
                  hintText: "Date",
                  hintStyle: TextStyle(),
                  labelText: "Date",
                  labelStyle: TextStyle(),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
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
                dropDownMenuItems: items.map(
                      (e) {
                        return e;
                      },
                    ).toList() ??
                    [],
                dropdownBackgroundColor: Colors.white,
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                onChanged: (value) {
                  setState(() {
                    dropdownvalue = value;
                  });
                  // if(value!=null)
                  // {
                  //   selected = value['class'].toString();
                  // }
                  // else{
                  //   selected=null;
                  // }
                },
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              buildTextFormFieldEmployeeExpense(
                  text: "Mobile number", textInputAction: TextInputAction.next),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              buildTextFormFieldEmployeeExpense(
                  text: "Amount", textInputAction: TextInputAction.next),
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
