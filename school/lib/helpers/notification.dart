import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

import '../models/bus_model.dart';

class NotificationHelper {
  NotificationHelper._();

  static final NotificationHelper notification = NotificationHelper._();

  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static   StreamController<BusModel> streamController = StreamController<BusModel>();
  static  int? id;
  static  List<QueryDocumentSnapshot<Map<String, dynamic>>>? data;
  static  double? MeterK;
  static  int not = 0;

  Future<void> fetchToken() async {
    String? token1 = await firebaseMessaging.getToken();

    print(token1);
  }

  Future<void> sendNotification() async {
    Map data = {
      "to":
          "esvIIYzpRauIi0OYAbuo4e:APA91bFY4rPNe6xtAmF_B_GVfwlTTx635Og6qnxb0euMsIA4RRSEy2Eg7hByEgtYE1DcQrE900yZ0f6NHIHlO7OEmZnuPFIMp3lfpZgjVKwPoVOUYUXdZgdQ3bI-F_fhkdj_myjFkH5t",
      "notification": {
        "content_available": true,
        "priority": "high",
        "title": "hello",
        "body": "My Body"
      },
      "data": {
        "priority": "high",
        "content_available": true,
        "school": "STGP",
        "age": "22"
      }
    };

    Map<String, String> data1 = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAArpw3DkU:APA91bFy3vI3eZUanb6p5V7WT85oWDUKHXt9Q_XgECIGJ8Tbepqg4lE8YVH5DvDez4zoY3qcpsrpPrFh5eHoybXmAEI0N3v0aw0aTvz0iON_6r8Ok_9kuuTXmty-S1i1w68EzqfRRheL",
    };

    String api = "https://fcm.googleapis.com/fcm/send";

    http.Response response =
        await http.post(Uri.parse(api), headers: data1, body: jsonEncode(data));

    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);
    }
  }

  Future<void> initializeNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        iOS: darwinInitializationSettings,
        android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print(details.payload);
      },
    );
  }

  Future<void> simpleNotification({required String title, required String body}) async {
    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("1", title);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        1, title, body, notificationDetails,payload: title);
  }
  getdata() async{
    QuerySnapshot<Map<String, dynamic>> k = await NotificationHelper.firebaseFirestore.collection('user').get();
    data =  k.docs;
    // setState(() {
    //
    // });
  }
  getUri() async {
    var queryParameters = {'start_index': '0', 'end_index': '100'};
    var uri = Uri.https('loconav.com', '/api/v3/device/all_devices_with_count',
        queryParameters);
    var response =
    await http.get(uri, headers: {'Authorization': 'zSgBeyDr3Co15xaBXrTa'});

    if (response.statusCode == 200) {
      final databody = jsonDecode(response.body);
      Map k = databody['data'][0]['data'];
      BusModel busModel = BusModel.fromJson(data: k);
      streamController.sink.add(busModel);
    }
  }




}
