import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videocall_app/utils/constants/colors.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const ButtonWidget({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        decoration: BoxDecoration(
            color: AppColor.purple, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.viga(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
