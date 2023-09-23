import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videocall_app/utils/constants/constant.dart';
import 'package:videocall_app/utils/shared_pref.dart';
import 'package:videocall_app/views/widgets/notification_item.dart';

import '../utils/constants/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> notiList = [
    // "Ricky Called you...",
    // "Stephanie Calling you...",
    // "Alex Messaged you",
    // "Kimberly Called you...",
    // "Kathy Messaged you",
    // "David  Messaged you",
    // "Stephanie Calling you...",
    // "Alex Messaged you",
    // "Kimberly Called you...",
    // "Kathy Messaged you",
    // "David  Messaged you"
  ];

  fetchLocalNotiList() {
    var _i = SharedPref.instance.shared.getString('notifications_list');
    print(SharedPref.instance.shared.getString('notifications_list'));
    List<dynamic> list = _i != null ? jsonDecode(_i)['notifications'] : [];
    if (list.isNotEmpty) {
      for (var e in list) {
        String username = e['title'];
        String notificationType = e['notification_type'];
        String callType = e['call_type'];
        String adminMsg = e['body'];

        // if (callType == 'call') {
        //   String str = "$username called you....";
        //   notiList.add(str);
        // }
        if (notificationType == 'incoming_call') {
          String str = "$username called you....";
          notiList.add(str);
        }
        if (notificationType == 'admin_message') {
          String str = username + ": " + adminMsg;
          notiList.add(str);
        }
        if (notificationType == 'text_message') {
          String str = "$username text message you....";
          notiList.add(str);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLocalNotiList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.asset("assets/images/background.png"),
            Positioned(
              top: 50,
              left: 10,
              right: 10,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    Constants.notifications,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      SharedPref.instance.shared.remove('notifications_list');
                      notiList = [];
                      setState(() {});
                    },
                    child: Text(
                      Constants.clearAll,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              top: 100,
              left: 0,
              child: Card(
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFFFFFF),
                          Color(0xFFFFFDFB),
                          Color(0xFFF3F4FF),
                        ],
                      )),
                  child: Stack(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: notiList.length,
                          itemBuilder: (context, index) {
                            return NotificationItem(
                              title: notiList[index],
                            );
                          }),
                      Positioned(
                        bottom: 0,
                        child: InkWell(
                          onTap: null,
                          child: Image.asset(
                            "assets/images/bottom.png",
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
