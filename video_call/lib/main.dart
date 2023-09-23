import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_callkit_incoming/entities/android_params.dart';
// import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
// import 'package:flutter_callkit_incoming/entities/ios_params.dart';
// import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:videocall_app/data/dio_api_service.dart';
import 'package:videocall_app/data/dio_connectivity_retrier.dart';
import 'package:videocall_app/data/logging_interceptor.dart';
import 'package:videocall_app/data/retrier_interceptor.dart';
import 'package:videocall_app/helper/helpers.dart';
import 'package:videocall_app/providers/auth_provider.dart';
import 'package:videocall_app/providers/chat_provider.dart';
import 'package:videocall_app/utils/data_type_extension.dart';
import 'package:videocall_app/utils/router/router.dart';
import 'package:videocall_app/utils/router/router_path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:videocall_app/utils/shared_pref.dart';
import 'package:videocall_app/utils/utils.dart';
import 'package:videocall_app/views/call/call_screen.dart';
import 'package:videocall_app/views/call/dial.dart';
import 'package:videocall_app/views/call/incoming_call.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('---------background message------');
  debugPrint(message.notification?.toMap().toString());
  debugPrint(message.data.toString());
  await SharedPref.instance.getSharedInstance();
  print(">>>>>>>>>>>>>>>>>> messagemessagemessagemessagemessage received");
  print(message.data);
  localmsgList(message);

  
  Helper.data = {
    'call_type': message.data['call_type'],
    'end_user_name': message.data['end_user_name'],
    'call_method': 'incoming',
    'user_length': int.parse(message.data['user_length']),
    'caller_fcm_token': message.data['caller_fcm_token'],
    'agora_channel': message.data['agora_channel'],
    'end_user_id': message.data['end_user_id'],
  };
  print(Helper.data);
  if (message.data['notification_type'] == 'incoming_call') {

    Helper.k = 1;
    // CallKitParams callKitParams = CallKitParams(
    //   id: message.data['end_user_id'],
    //   nameCaller: message.data['end_user_name'],
    //   appName: 'Demo',
    //   avatar:
    //       'https://th.bing.com/th/id/OIP.s1b9yCCw10YqK0jbedmi-AHaHa?pid=ImgDet&rs=1',
    //   handle: 'Ringing...',
    //   type: 0,
    //   textAccept: 'Accept',
    //   textDecline: 'Decline',
    //   textMissedCall: 'Missed call',
    //   textCallback: 'Call back',
    //   duration: 30000,
    //   extra: <String, dynamic>{'userId': message.data['end_user_id']},
    //   android: const AndroidParams(
    //       isCustomNotification: true,
    //       isShowLogo: false,
    //       isShowCallback: false,
    //       isShowMissedCallNotification: true,
    //       ringtonePath: 'system_ringtone_default',
    //       backgroundColor: '#0955fa',  
    //       actionColor: '#4CAF50',
    //       incomingCallNotificationChannelName: "Incoming Call",
    //       missedCallNotificationChannelName: "Missed Call"),
    //   ios: IOSParams(
    //     iconName: message.data['end_user_name'],
    //     handleType: 'generic',
    //     supportsVideo: true,
    //     maximumCallGroups: 2,
    //     maximumCallsPerCallGroup: 1,
    //     audioSessionMode: 'default',
    //     audioSessionActive: true,
    //     audioSessionPreferredSampleRate: 44100.0,
    //     audioSessionPreferredIOBufferDuration: 0.005,
    //     supportsDTMF: true,
    //     supportsHolding: true,
    //     supportsGrouping: false,
    //     supportsUngrouping: false,
    //     ringtonePath: 'system_ringtone_default',
    //   ),
    // );
    // await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);

    if (DateTime.now()
            .difference(DateTime.parse(message.data['time']))
            .inSeconds <
        30) {
      String? strCallArg =
          SharedPref.instance.shared.getString('notifications_callArg');
      if (strCallArg.validate().isEmpty) {
        Map<String, dynamic> callArg = {
          'call_type': message.data['call_type'],
          'end_user_name': message.data['end_user_name'],
          'call_method': 'incoming',
          'user_length': int.parse(message.data['user_length']),
          'caller_fcm_token': message.data['caller_fcm_token'],
          'agora_channel': message.data['agora_channel'],
          'end_user_id': message.data['end_user_id'],
        };

        SharedPref.instance.shared
            .setString('notifications_callArg', jsonEncode(callArg));

        Utils.showLocalNotification(
            title: 'incoming call',
            subTitle: message.data['end_user_name'] ?? '',
            payload: message.data,
            notificationId: 99999999);
      }

      Navigator.pushNamed(navigatorKey.currentContext!, RoutePath.incomingCall,
          arguments: {
            'call_type': message.data['call_type'],
            'end_user_name': message.data['end_user_name'],
            'call_method': 'incoming',
            'user_length': int.parse(message.data['user_length']),
            'caller_fcm_token': message.data['caller_fcm_token'],
            'agora_channel': message.data['agora_channel'],
            'end_user_id': message.data['end_user_id'],
          });

      // Utils.callStream.add({
      //   'call_type': .data['call_type'],
      //   'end_user_name': message.data['end_user_name'],
      //   'cur_user_id': message.data['caller_user_id'],
      //   'call_method': 'dialing',
      //   'user_length': 0,
      //   'end_user_fcm_token': message.data['caller_fcm_token'],
      //   'agora_channel': message.data['agora_channel'],
      // });
    }
  }
  await Firebase.initializeApp();
}

Future<void> localmsgList(message) async {
  Map<String, dynamic> _noti = {
    'title': message.data['end_user_name'],
    'notification_type': message.data['notification_type'],
    'call_type': message.data['call_type'],
    'body': message.notification?.body ?? 'My warning',
  };
  String? notificationsString =
      SharedPref.instance.shared.getString('notifications_list');
  if (notificationsString != null) {
    List<dynamic> list = jsonDecode(notificationsString)['notifications'];
    list.add(_noti);
    Map<String, dynamic> _d = {'notifications': list};
    SharedPref.instance.shared.setString('notifications_list', jsonEncode(_d));
    SharedPref.instance.shared
        .setString('notifications_icon_badge', list.length.toString());
    var sssss =
        SharedPref.instance.shared.getString('notifications_icon_badge');
  } else {
    Map<String, dynamic> _d = {
      'notifications': [_noti]
    };

    SharedPref.instance.shared.setString('notifications_list', jsonEncode(_d));
    SharedPref.instance.shared
        .setString('notifications_icon_badge', _d.length.toString());
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPref.instance.getSharedInstance();

  Utils.listenToSocket();
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // FCM notification handler
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // initialize local notification
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification:
              (e, dynamic e2, dynamic e3, dynamic e4) => {});
  const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  if (Platform.isAndroid) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();
  }

  if (Platform.isIOS) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  FirebaseMessaging.onMessage.listen((event) {
    print(">>>>>>>>>>>>>>>>>> notificaiton received");
    print(event.data);
    if (event.data['notification_type'] == 'admin_message') {
      localmsgList(event);
    }
    if (event.data['notification_type'] == 'incoming_call') {
      Navigator.pushNamed(navigatorKey.currentContext!, RoutePath.incomingCall,
          arguments: {
            'call_type': event.data['call_type'],
            'end_user_name': event.data['end_user_name'],
            'call_method': 'incoming',
            'user_length': int.parse(event.data['user_length']),
            'caller_fcm_token': event.data['caller_fcm_token'],
            'agora_channel': event.data['agora_channel'],
            'end_user_id': event.data['end_user_id'],
          });
    } else if (event.data['notification_type'] == 'call_decline') {
      print("............................... call decline ------->>>>>");
      Utils.callStream.add(null);
      Navigator.pop(navigatorKey.currentContext!);
    } else {
      Utils.showLocalNotification(
          title: event.notification?.title ?? '',
          subTitle: event.notification?.body ?? '',
          payload: event.data);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
    print(">>>>>>>>>>>>>>>>>> on message open appppp------->>>>>.");
    print(event.data);
    if (event.data['notification_type'] == 'admin_message') {
      localmsgList(event);
    }
    if (event.data['notification_type'] == 'incoming_call') {
      if (DateTime.now()
              .difference(DateTime.parse(event.data['time']))
              .inSeconds <
          30) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, RoutePath.incomingCall,
            arguments: {
              'call_type': event.data['call_type'],
              'end_user_name': event.data['end_user_name'],
              'call_method': 'incoming',
              'user_length': int.parse(event.data['user_length']),
              'caller_fcm_token': event.data['caller_fcm_token'],
              'agora_channel': event.data['agora_channel'],
              'end_user_id': event.data['end_user_id'],
            });
        // Utils.callStream.add({
        //   'call_type': event.data['call_type'],
        //   'end_user_name': event.data['end_user_name'],
        //   'cur_user_id': event.data['caller_user_id'],
        //   'call_method': 'dialing',
        //   'user_length': 0,
        //   'end_user_fcm_token': event.data['caller_fcm_token'],
        //   'agora_channel': event.data['agora_channel'],
        // });
      }
    }
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  if (await Permission.locationAlways.status == PermissionStatus.denied ||
      await Permission.locationAlways.status == PermissionStatus.limited ||
      await Permission.locationAlways.status == PermissionStatus.restricted ||
      await Permission.locationAlways.status ==
          PermissionStatus.permanentlyDenied) {
    Permission.location.request();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Dio _dio = DioApiService.dio;

    _dio.interceptors.addAll([
      LoggingInterceptor(),
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: _dio,
          connectivity: Connectivity(),
        ),
      ),
    ]);
    if (SharedPref.instance.shared.getString('token') != null &&
        SharedPref.instance.shared.getString('token') != '') {
      print("---------------- updating fcm token ------------");
      Utils.updateFcmToken();
    }
  }

  dynamic height;
  dynamic width;

  double x = 10;
  double y = 30;

  double? screenHeight;
  double? screenWidth;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => AuthProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => ChatProvider(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'VideoCall App',
              key: Utils.navKey,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              navigatorKey: navigatorKey,
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute:
                  SharedPref.instance.shared.getString('token') != '' &&
                          SharedPref.instance.shared.getString('token') != null
                      ? RoutePath.homeParent
                      : RoutePath.splash,
            ),
          ),
          MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: (context, child) => StreamBuilder<dynamic>(
              stream: Utils.callStream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  Map<String, dynamic> arg = snapshot.data;
                  print("???????????????? ----e-eeeeee");
                  print(arg);
                  if (arg['cur_user_id'] != null &&
                      arg['end_user_name'] != null &&
                      arg['end_user_fcm_token'] != null &&
                      arg['call_type'] != null) {
                    var hh = height ?? MediaQuery.of(context).size.height;
                    screenHeight = MediaQuery.of(context).size.height;
                    screenWidth = MediaQuery.of(context).size.width;
                    return GestureDetector(
                      onPanUpdate: (detail) {
                        x = detail.globalPosition.dx;
                        y = detail.globalPosition.dy;
                        if (y > (screenHeight! - 200)) {
                          y = screenHeight! - 200;
                        }
                        if (x > (screenWidth! - 200)) {
                          x = screenWidth! - 200;
                        }
                        debugPrint("x_y_position: $x, $y");
                        setState(() {});
                      },
                      child: Container(
                        height: hh,
                        width: width ?? MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                          left: (hh > 200) ? 0 : (x < 0 ? 0 : x),
                          top: (hh > 200) ? 0 : (y < 0 ? 0 : y),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CallScreen(
                          curuserId: arg['cur_user_id'],
                          enduserName: arg['end_user_name'],
                          callType: arg['call_type'],
                          endUserFcmToken: arg['end_user_fcm_token'],
                          agoraChannel: arg['agora_channel'],
                          endUserId: arg['end_user_id'],
                          height: height ?? MediaQuery.of(context).size.height,
                          callMembersFcm: arg['call_members'],
                          callback: (h, w) {
                            height = h;
                            width = w;
                            setState(() {});
                          },
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
