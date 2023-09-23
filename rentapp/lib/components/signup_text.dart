import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';
import '../views/screens/LoginScreens/select_category/select_category_screen.dart';
class SignUpText extends StatelessWidget {
  const SignUpText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
            color: Colors.grey.shade600,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, SelectCategory.routeName);
          },
          child: Text(
            " Sign Up",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
