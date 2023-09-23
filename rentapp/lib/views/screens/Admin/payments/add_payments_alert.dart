import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentapp/size_config.dart';
import 'package:searchfield/searchfield.dart';


class AddPaymentsAlert extends StatefulWidget {
  const AddPaymentsAlert({super.key});

  @override
  State<AddPaymentsAlert> createState() => _AddPaymentsAlertState();
}

class _AddPaymentsAlertState extends State<AddPaymentsAlert> {
 GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  TextEditingController _textEditingController = TextEditingController();
  String? selectionCount;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return AlertDialog(
      title: Center(
        child: Text(
          "Add Payment",
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenHeight(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: SearchField(
                  hint: "Contact",
                  textInputAction: TextInputAction.next ,
                  searchInputDecoration: InputDecoration(
                    labelText: "Contact",
                    enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.screenHeight * 0.03),
                  ),
                  ),
                  onSuggestionTap: (val) {
                    setState(() {
                      selectionCount = val.toString();
                    });
                  },
                  
                  itemHeight: getProportionateScreenHeight(50),
                  maxSuggestionsInViewPort: 6,
                  suggestionsDecoration: SuggestionDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenHeight(10)),
                  ),
                  suggestions: [
                    SearchFieldListItem("Parth Dhameliya"),
                    SearchFieldListItem("Om Gujarati"),
                    SearchFieldListItem("Komal"),
                    SearchFieldListItem("Hitesh"),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              buildTextFormFieldEmployeeExpense(
                  text: "Bank Account", textInputAction: TextInputAction.next),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              buildTextFormFieldEmployeeExpense(
                  text: "Amount", textInputAction: TextInputAction.next),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              buildTextFormFieldEmployeeExpense(
                  text: "Cheque Number", textInputAction: TextInputAction.next),
              

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