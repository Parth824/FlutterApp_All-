import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videocall_app/utils/constants/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? isPassword;
  final String? Function(String?)? validator;
  const TextFieldWidget(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.validator,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword!,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.viga(fontSize: 14),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColor.darkGrey,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColor.lightGrey,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColor.lightGrey,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColor.lightGrey,
            width: 1.0,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
