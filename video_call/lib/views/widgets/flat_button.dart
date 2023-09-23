import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants/colors.dart';

class FlatButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const FlatButtonWidget({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.primary),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.viga(fontSize: 16, color: AppColor.primary),
          ),
        ),
      ),
    );
  }
}
