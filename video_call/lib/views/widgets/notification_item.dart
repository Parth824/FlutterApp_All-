import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videocall_app/utils/constants/colors.dart';

class NotificationItem extends StatelessWidget {
  final String title;

  const NotificationItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: AppColor.lightPurple,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Image.asset(
                "assets/images/notification.png",
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.69,
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColor.blackShade1),
                ))
          ],
        ),
      ),
    );
  }
}
