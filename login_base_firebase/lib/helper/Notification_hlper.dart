import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHlper {
  NotificationHlper._();

  static final NotificationHlper notificationHlper = NotificationHlper._();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void intinotfication() {
    var androidinitializationsettings =
        AndroidInitializationSettings("mipmap/ic_launcher");
    var darwinintializationsetting = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidinitializationsettings,
        iOS: darwinintializationsetting);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("==============");
        print(details.payload);
        print("==============");
      },
    );
  }

  Future<void> showSimpleNotification({String? tital,String? body}) async {
    var androidnotificationdetails = AndroidNotificationDetails(
      "$tital",
      "$body",
      priority: Priority.high,
      importance: Importance.max,
    );
    var darwinnotificationdetails = DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(
        android: androidnotificationdetails, iOS: darwinnotificationdetails);
    await flutterLocalNotificationsPlugin.show(
        1, "$tital", "$body", notificationDetails,
        payload: "Succfully run...");
  }

  Future<void> showShudingNotification() async {
    var androidnotificationdetails = AndroidNotificationDetails(
      "duumy",
      "Simple",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    var darwinnotificationdetails = DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(
        android: androidnotificationdetails, iOS: darwinnotificationdetails);

    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      "Simple",
      "My Simeple NOtification...",
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
      notificationDetails,
      payload: "Succfully run...",
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showBigPicNotification() async {
    var bigpicturestyleinfromation = BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
    );
    var androidnotificationdetails = AndroidNotificationDetails(
      "duumy",
      "Simple",
      channelDescription: "My name is Parth",
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      styleInformation: bigpicturestyleinfromation,
    );
    var notificationDetails =
        NotificationDetails(android: androidnotificationdetails, iOS: null);
    await flutterLocalNotificationsPlugin.show(
        1, "Simple", "My Simeple NOtification...", notificationDetails,
        payload: "Succfully run...");
  }

  showMediaStyleNotification() async {
    var androidnotificationdetails = AndroidNotificationDetails(
      "duumy",
      "Simple",
      channelDescription: "My name is Parth",
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      styleInformation: MediaStyleInformation(),
    );
    var notificationDetails =
        NotificationDetails(android: androidnotificationdetails, iOS: null);
    await flutterLocalNotificationsPlugin.show(
        1, "Simple", "My Simeple NOtification...", notificationDetails,
        payload: "Succfully run...");
  }
}
