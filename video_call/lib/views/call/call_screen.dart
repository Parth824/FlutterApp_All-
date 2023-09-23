import 'dart:developer';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:videocall_app/data/dio_api_service.dart';
import 'package:videocall_app/utils/constants/app_config.dart';
import 'package:videocall_app/utils/shared_pref.dart';
import 'package:videocall_app/utils/utils.dart';
import 'package:videocall_app/views/call/dial.dart';

bool isCallConnected = false;
int callConnectStatus = -1;

class CallScreen extends StatefulWidget {
  final String enduserName;
  final String curuserId;
  final String callType;
  final String endUserFcmToken;
  final Function(dynamic height, dynamic width) callback;
  final dynamic height;
  List? callMembersFcm;
  final String agoraChannel;
  final String endUserId;

  CallScreen({
    super.key,
    required this.curuserId,
    required this.enduserName,
    required this.callType,
    required this.endUserFcmToken,
    required this.callback,
    required this.height,
    this.callMembersFcm,
    required this.agoraChannel,
    required this.endUserId,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  bool isCallPickedUp = false;
  bool enableSpeakerphone = false;
  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};

  void createAgoraEngine() {
    _engine = createAgoraRtcEngine();
  }

  Future<void> _initEngine() async {
    await [Permission.microphone, Permission.camera].request();
    await _engine.initialize(const RtcEngineContext(
      appId: AppConfig.agoraAppId,
    ));
    isCallConnected = true;
    addCallHistory(0);
    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        debugPrint('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        debugPrint(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        debugPrint(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        setState(() {
          isCallPickedUp = true;
          remoteUid.add(rUid);
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        debugPrint(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {
          remoteUid.removeWhere((element) => element == rUid);
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        debugPrint(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));
    if (widget.callType == 'video') {
      await _engine.enableVideo();
      await _engine.enableAudio();
      await _engine.setVideoEncoderConfiguration(
        const VideoEncoderConfiguration(
          dimensions: VideoDimensions(width: 640, height: 360),
          frameRate: 15,
          bitrate: 0,
        ),
      );
    } else {
      await _engine.enableAudio();
      await _engine.setDefaultAudioRouteToSpeakerphone(false);
    }

    await _joinChannel();
    setState(() {
      _isReadyPreview = true;
    });
  }

  Future<void> _joinChannel() async {
    await _engine.startPreview();

    var response = await DioApiService.generateAgoraToken(
      channel: widget.agoraChannel,
      uid: widget.curuserId.toString(),
    );

    await _engine.joinChannel(
      token: response,
      channelId: widget.agoraChannel,
      uid: int.parse(widget.curuserId),
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  switchSpeakerphone() async {
    await _engine.setEnableSpeakerphone(!enableSpeakerphone);
    setState(() {
      enableSpeakerphone = !enableSpeakerphone;
    });
  }

  Future<void> _switchCamera() async {
    await _engine.switchCamera();
    setState(() {
      switchCamera = !switchCamera;
    });
  }

  Future addCallHistory(int callStatus) async {
    //'receiver_user_id' => 'required',
    //                 'sender_user_id' => 'required',
    //                 'duration' => 'required',
    //                 'status' => 'required'
    var localUserId = SharedPref.instance.shared.getInt('login_user_id');
    debugPrint(
        "addCallHistory_currentUserId: ${widget.curuserId}, endUserId: ${widget.endUserId}, localUserId: $localUserId");

    if (callStatus == callConnectStatus ||
        widget.endUserId == localUserId.toString()) {
      return;
    }
    callConnectStatus = callStatus;
    Map<String, dynamic> body = {
      // "id": 2,
      "receiver_user_id": widget.endUserId,
      "sender_user_id": widget.curuserId,
      "duration": 0,
      "name": widget.enduserName,
      "status": callStatus, //1 = missed, 2= cut , 3 received
      "created_at": DateTime.now().toString(),
      "updated_at": DateTime.now().toString(),
      "json_data": ""
    };
    // updateIsLoading(true);
    dynamic response = await DioApiService.addCallHistory(body);
    // updateIsLoading(false);

    return response;
  }

  @override
  void initState() {
    super.initState();
    createAgoraEngine();
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Widget build(BuildContext context) {
    if (isCallPickedUp == true && remoteUid.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        // Navigator.pop(context);
        _dispose();
        Utils.callStream.add(null);
      });
    }
    if (widget.callType == 'audio') {
      return DialScreen(
        callType: 'audio',
        endUserName: widget.enduserName,
        callMethod: 'dialing',
        userLength: remoteUid.length,
        endUserFcmToken: widget.endUserFcmToken,
        engine: _engine,
        callback: widget.callback,
        isSmall: widget.height > 150 ? false : true,
        switchAudioInput: switchSpeakerphone,
      );
    }
    return (widget.height > 200 ? false : true) == true
        ? Container(
            height: 200,
            width: 200,
            color: Colors.red,
            child: Stack(
              children: [
                Visibility(
                  visible: _isReadyPreview,
                  child: Container(
                    color: Colors.white,
                    child: AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: _engine,
                        canvas: const VideoCanvas(uid: 0),
                      ),
                    ),
                  ),
                ),
                if (remoteUid.isNotEmpty)
                  SizedBox(
                    child: AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: _engine,
                        canvas: VideoCanvas(uid: remoteUid.elementAt(0)),
                      ),
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
                        color: Colors.black.withOpacity(0.5),
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
          )
        : remoteUid.length > 1
            ? SafeArea(
                child: Scaffold(
                  body: Stack(
                    children: [
                      Visibility(
                        visible: _isReadyPreview,
                        child: Container(
                          color: Colors.white,
                          child: AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: _engine,
                              canvas: const VideoCanvas(uid: 0),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.of(remoteUid.map(
                              (e) => SizedBox(
                                width: 120,
                                height: 120,
                                child: AgoraVideoView(
                                  controller: VideoViewController(
                                    rtcEngine: _engine,
                                    canvas: VideoCanvas(uid: e),
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ),
                      ),
                      callActions(),
                    ],
                  ),
                ),
              )
            : SafeArea(
                child: Scaffold(
                  body: Stack(
                    children: [
                      if (!_isReadyPreview)
                        Container(
                          color: Colors.white,
                        ),
                      Visibility(
                        visible: _isReadyPreview,
                        child: Container(
                          color: Colors.white,
                          child: AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: _engine,
                              canvas: const VideoCanvas(uid: 0),
                            ),
                          ),
                        ),
                      ),
                      if (remoteUid.isNotEmpty)
                        SizedBox(
                          child: AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: _engine,
                              canvas: VideoCanvas(uid: remoteUid.elementAt(0)),
                            ),
                          ),
                        ),
                      Visibility(
                        visible: remoteUid.isNotEmpty,
                        child: Container(
                          width: 120,
                          height: 150,
                          color: Colors.white,
                          child: AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: _engine,
                              canvas: const VideoCanvas(uid: 0),
                            ),
                          ),
                        ),
                      ),
                      callActions(),
                    ],
                  ),
                ),
              );
  }

  Container callActions() {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                widget.callback(200.0, 200.0);
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Icon(Icons.screen_rotation_alt),
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            SizedBox(
              height: 65,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context);
                  print(">>>>>>>>>>>>>>>>>>>>>>>> 555555 ${remoteUid.length}");
                  if (remoteUid.isEmpty && widget.callMembersFcm != null) {
                    for (var fcm in widget.callMembersFcm!) {
                      Utils.sendMessage(
                        title: 'missed call',
                        msg: 'call',
                        receiverFcmToken: fcm,
                        data: {
                          'notification_type': 'call_decline',
                        },
                      );
                    }
                  }
                  _dispose();
                  Utils.callStream.add(null);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.red),
                  shape: MaterialStateProperty.resolveWith(
                    (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
                child: const Icon(Icons.call_end),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            GestureDetector(
              onTap: () {
                _switchCamera();
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
                    Icons.cameraswitch,
                    color: Colors.white,
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
