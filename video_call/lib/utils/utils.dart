import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:videocall_app/data/dio_api_service.dart';
import 'package:videocall_app/utils/constants/app_config.dart';
import 'package:videocall_app/utils/shared_pref.dart';

class Utils {
  Utils._();

  static GlobalKey navKey = GlobalKey();

  static void showSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static StreamController chatPushStream = StreamController.broadcast();
  static StreamController chatListenStream = StreamController.broadcast();

  static void listenToSocket() {
    if (SharedPref.instance.shared.getString('userobj') != null) {
      var localUserId =
          jsonDecode(SharedPref.instance.shared.getString('userobj')!)['id'];
      if (localUserId != null) {
        IO.Socket socket = IO.io(AppConfig.chat_soket_url, <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': true,
        });
        socket.onConnect((_) {
          print('>>>>>>>>>>>>>>>>>> connected---${localUserId}');
          chatPushStream.stream.listen((data) {
            print('->>>>>>>>>>>>>>>>. pushing new mssg');
            print(data);
            socket.emit('newMessage_V', data);
          });
        });

        socket.on('MessageReceived_V$localUserId', (data) {
          print('>>>>>>>>>>>>> MessageReceived');
          print(data);
          chatListenStream.sink.add(data);
        });

        socket.onDisconnect((_) => print('disconnect'));

        socket.onError((data) {
          print('>>>>>>>>>>>>>>>>>> socker error');
          print(data);
        });

        socket.onConnectError((data) {
          print('>>>>>>>>>>>>>>>>>> connection error');
          print(data);
        });
      }
    }
  }

  static void logout() {}

  static Future<void> sendMessage(
      {required String receiverFcmToken,
      required String msg,
      required String title,
      required Map<String, dynamic> data}) async {
    /// PROD MODE SERVER KEY
    var serverKey = AppConfig.fcmServerKey;

    if (receiverFcmToken == '') {
      return;
    }
    try {
      Response response = await Dio().post(
        'https://fcm.googleapis.com/fcm/send',
        options: Options(contentType: 'application/json', headers: {
          'Authorization': 'key=$serverKey',
        }),
        data: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': msg,
              'title': title,
              // "click_action": "OPEN_ACTIVITY_1"
            },
            'priority': 'high',
            'data': data,
            'to': receiverFcmToken,
          },
        ),
      );
      print("--------------------- fcm response ----------------");
      print(response);
    } catch (e) {
      print("error push notification");
    }
  }

  static StreamController callStream = StreamController.broadcast();

  static void showLocalNotification(
      {required String title,
      required String subTitle,
      required Map<String, dynamic> payload, int? notificationId}) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('high_importance_channel', 'callapp',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            enableVibration: true,
            enableLights: true,
            playSound: true,
            ticker: 'ticker');

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: const DarwinNotificationDetails(
          presentAlert: true, presentSound: true),
    );
    flutterLocalNotificationsPlugin.cancelAll();
    await flutterLocalNotificationsPlugin.show(
      notificationId??Random().nextInt(9999999),
      title,
      subTitle,
      notificationDetails,
      payload: jsonEncode(payload),
    );
  }

  static updateFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null && token != '') {
      DioApiService.updateUserFcmToken(token: token);
    }
  }

  static String utcToLocal(String dateTime) {
    //2023-02-23 20:51:55.067319
    String ddd = dateTime.replaceAll("T", " ");
    if (ddd.length > 16) {
      return DateTime.parse(ddd).toLocal().toString().substring(0, 16);
    }
    return DateTime.parse(ddd).toLocal().toString();
  }
}
