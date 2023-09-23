import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:videocall_app/utils/constants/colors.dart';
import 'package:videocall_app/utils/utils.dart';

class DialScreen extends StatefulWidget {
  final String callType;
  final String endUserName;
  final String callMethod;
  final int userLength;
  final String? endUserFcmToken;
  final RtcEngine engine;
  final bool? isSmall;
  final Function switchAudioInput;
  final Function(dynamic height, dynamic width) callback;

  const DialScreen({
    super.key,
    required this.callType,
    required this.endUserName,
    required this.callMethod,
    required this.userLength,
    required this.endUserFcmToken,
    required this.engine,
    this.isSmall,
    required this.switchAudioInput,
    required this.callback,
  });

  @override
  State<DialScreen> createState() => _DialScreenState();
}

class _DialScreenState extends State<DialScreen> {
  int callDuration = 0;
  bool isTimerRunning = false;
  Timer? _timer;
  checkCallDuration() {
    if (widget.userLength > 0 && isTimerRunning == false) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          callDuration++;
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

  changeMic() {
    // widget.engine.e
  }

  @override
  void dispose() {
    super.dispose();
    isTimerRunning = false;
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkCallDuration();
    // if (isTimerRunning == true && widget.userLength == 0) {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     Navigator.pop(context);
    //   });
    // }
    final Size size = MediaQuery.of(context).size;
    return widget.isSmall == true
        ? Scaffold(
            body: Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      widget.endUserName,
                      style:
                          const TextStyle(fontSize: 17, color: AppColor.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        widget.callback(MediaQuery.of(context).size.height,
                            MediaQuery.of(context).size.width);
                      },
                      child: Container(
                        height: 22,
                        width: 22,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.expand,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: AppColor.primary,
            body: Column(
              children: [
                const SizedBox(
                  height: 45,
                ),
                GestureDetector(
                  onTap: () {
                    widget.callback(150.0, 200.0);
                  },
                  child: Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(left: 20),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
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
                  visible: widget.userLength > 0,
                  child: Center(
                    child: Text(
                      formatedTime(timeInSecond: callDuration),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.userLength <= 0,
                  child: const Center(
                    child: Text(
                      'Calling...',
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
                          // NavigatorState navigatorState = Navigator.of(context);
                          if (widget.endUserFcmToken != null &&
                              isTimerRunning == false) {
                            // await Utils.sendMessage(
                            //   title: 'call declined',
                            //   msg: '',
                            //   receiverFcmToken: widget.endUserFcmToken!,
                            //   data: {
                            //     'notification_type': 'call_decline',
                            //   },
                            // );
                            Utils.callStream.add(null);
                          }
                          // navigatorState.pop();
                          Utils.callStream.add(null);
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
                          onPressed: () async {},
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
                    const SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.switchAudioInput();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.spatial_audio,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
