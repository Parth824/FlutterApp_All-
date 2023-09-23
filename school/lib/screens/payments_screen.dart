import 'package:flutter/material.dart';

class PaymentsScreen extends StatelessWidget {
  static String id = 'payments_screen';
  const PaymentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Padding(
        padding: EdgeInsets.only(left: 5, right: 14),
        child: Center(
          child: Text(
            "Congratulations!!! \nYou are a free user till 1st of July",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
