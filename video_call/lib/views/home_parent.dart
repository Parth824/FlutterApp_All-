import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:videocall_app/utils/utils.dart';
import 'package:videocall_app/views/call/call_screen.dart';
import 'package:videocall_app/views/home.dart';

class HomeParent extends StatefulWidget {
  const HomeParent({super.key});

  @override
  State<HomeParent> createState() => _HomeParentState();
}

class _HomeParentState extends State<HomeParent> {
  dynamic x;
  dynamic y;
  Size? size;

  dynamic height;
  dynamic width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // print(size!.width * 0.475);
    return Scaffold(
      body: Stack(
        children: [
          const HomeScreen(),
          // Positioned(
          //   top: y ?? size!.height * 0.67,
          //   left: x ?? size!.width * 0.47,
          //   child: Draggable(
          //     feedback: Container(
          //       height: 200,
          //       width: 200,
          //       color: Colors.red,
          //     ),
          //     childWhenDragging: SizedBox(),
          //     // childWhenDragging: Container(
          //     //   height: 200,
          //     //   width: 200,
          //     //   color: Colors.yellow,
          //     // ),
          //     onDragEnd: (details) {
          //       print(">>>>>>>>>>>>>>> X : -> ${details.offset.dx}");
          //       print(">>>>>>>>>>>>>>> Y : -> ${details.offset.dy}");
          //       setState(() {
          //         if (details.offset.dx < size!.width * 0.475 &&
          //             details.offset.dx > 10) {
          //           x = details.offset.dx;
          //         } else {
          //           // x = size!.width * 0.475;
          //         }
          //         if (details.offset.dy < size!.height * 0.67 &&
          //             details.offset.dy > 40) {
          //           y = details.offset.dy;
          //         } else if (details.offset.dy < 40) {
          //           y = 40.0;
          //         } else {
          //           y = size!.height * 0.67;
          //         }
          //       });
          //     },
          //     child: StreamBuilder<dynamic>(
          //       stream: Utils.callStream.stream,
          //       builder: (context, snapshot) {
          //         log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>666666");
          //         print(snapshot.data);
          //         if (snapshot.hasData && snapshot.data != null) {
          //           Map<String, dynamic> arg = snapshot.data;
          //           log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>calllllll");
          //           if (arg['cur_user_id'] != null &&
          //               arg['end_user_name'] != null &&
          //               arg['end_user_fcm_token'] != null &&
          //               arg['call_type'] != null) {
          //             return Container(
          //               margin:
          //                   (height ?? MediaQuery.of(context).size.height) <=
          //                           200
          //                       ? const EdgeInsets.only(bottom: 70)
          //                       : EdgeInsets.zero,
          //               alignment: Alignment.bottomRight,
          //               child: Container(
          //                 height: height ?? MediaQuery.of(context).size.height,
          //                 width: width ?? MediaQuery.of(context).size.width,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(12),
          //                 ),
          //                 child: CallScreen(
          //                   curuserId: arg['cur_user_id'],
          //                   enduserName: arg['end_user_name'],
          //                   callType: arg['call_type'],
          //                   endUserFcmToken: arg['end_user_fcm_token'],
          //                   height:
          //                       height ?? MediaQuery.of(context).size.height,
          //                   callback: (h, w) {
          //                     height = h;
          //                     width = w;
          //                     setState(() {});
          //                   },
          //                 ),
          //               ),
          //             );
          //           } else {
          //             return const SizedBox();
          //           }
          //         } else {
          //           return const SizedBox();
          //         }
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
