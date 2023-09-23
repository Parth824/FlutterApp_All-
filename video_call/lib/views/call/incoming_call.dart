import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videocall_app/providers/auth_provider.dart';
import 'package:videocall_app/utils/constants/app_config.dart';
import 'package:videocall_app/utils/constants/colors.dart';
import 'package:videocall_app/utils/router/router_path.dart';
import 'package:videocall_app/utils/utils.dart';

class IncomingCall extends StatefulWidget {
  final String callType;
  final String endUserName;
  final String callMethod;
  final int? userLength;
  final String? callerFcmToken;
  final String agoraChannel;
  final String endUserId;

  const IncomingCall({
    super.key,
    required this.callType,
    required this.endUserName,
    required this.callMethod,
    required this.userLength,
    required this.callerFcmToken,
    required this.agoraChannel,
    required this.endUserId,
  });

  @override
  State<IncomingCall> createState() => _IncomingCallState();
}

class _IncomingCallState extends State<IncomingCall> {
  int callDuration = 0;
  bool isTimerRunning = false;

  checkCallDuration() {
    if ((widget.userLength ?? 0) > 0 && isTimerRunning == false) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Timer.periodic(const Duration(seconds: 1), (timer) {
          callDuration++;
          if (isTimerRunning == true) {
            FlutterRingtonePlayer.stop();
          }
          isTimerRunning = true;
          setState(() {});
        });
      });
    }
  }

  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    String hour = (min / 60).toString().split('.')[0];
    if (hour != '0' && hour != '') {
      return "$hour : ${(int.parse(minute) - (int.parse(hour) * 60) < 9 ? '0' : '')}${int.parse(minute) - (int.parse(hour) * 60)} : $second";
    } else {
      return "$minute : $second";
    }
    // return "$minute : $second";
  }

  Timer? timer;
  int secondsRings = 0;
  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    isTimerRunning = false;
    FlutterRingtonePlayer.stop();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          secondsRings++;
        });
      });
    });
    FlutterRingtonePlayer.play(
        android: AndroidSounds.ringtone,
        ios: IosSounds.glass,
        looping: true,
        volume: 1,
        asAlarm: false // will be the sound on iOS
        );
  }

  declinecall() {
    NavigatorState navigatorState = Navigator.of(context);
    timer?.cancel();
    if (widget.callerFcmToken != null) {
      Utils.sendMessage(
        title: 'call declined',
        msg: '',
        receiverFcmToken: widget.callerFcmToken!,
        data: {
          'notification_type': 'call_decline',
        },
      );
    }
    navigatorState.pop();
  }

  @override
  Widget build(BuildContext context) {
    checkCallDuration();

    if (secondsRings > 30) {
      declinecall();
    }
    final Size size = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Scaffold(
        backgroundColor: AppColor.primary,
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            Center(
              child: Text(
                widget.endUserName,
                style: const TextStyle(fontSize: 35, color: AppColor.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: (widget.userLength ?? 0) > 0,
              child: Center(
                child: Text(
                  formatedTime(timeInSecond: callDuration),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            Visibility(
              visible: (widget.userLength ?? 0) <= 0,
              child: const Center(
                child: Text(
                  'Ringing...',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.grey),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () async {
                      declinecall();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red),
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                    ),
                    child: const Icon(Icons.call_end),
                  ),
                ),
                Visibility(
                  visible: widget.callMethod != 'dialing',
                  child: SizedBox(
                    width: size.width * 0.3,
                  ),
                ),
                Visibility(
                  visible: widget.callMethod != 'dialing',
                  child: SizedBox(
                    height: 65,
                    child: ElevatedButton(
                      onPressed: () {
                        Utils.callStream.add({
                          'call_type': widget.callType,
                          'end_user_name': widget.endUserName,
                          'cur_user_id': authProvider.user?.data.id.toString(),
                          'call_method': widget.callMethod,
                          'user_length': 0,
                          'end_user_fcm_token': widget.callerFcmToken,
                          'agora_channel': widget.agoraChannel,
                          'end_user_id': widget.endUserId,
                        });
                        Navigator.pop(context);
                        // Navigator.popAndPushNamed(context, RoutePath.callScreen,
                        //     arguments: {
                        //       'call_type': widget.callType,
                        //       'end_user_name': widget.endUserName,
                        //       'cur_user_id': authProvider.user?.data.id,
                        //       'call_method': widget.callMethod,
                        //       'end_user_fcm_token': widget.callerFcmToken,
                        //     });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                      ),
                      child: const Icon(Icons.call),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
