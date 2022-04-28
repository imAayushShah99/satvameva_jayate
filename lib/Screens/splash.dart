import 'dart:math';

import 'package:audioplayers/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../Services/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  static final flrtNotifications = FlutterLocalNotificationsPlugin();

  PrefServices prefService = PrefServices();

  @override
  void initState() {
    login();

    super.initState();
    tz.initializeTimeZones();

    var androidInitilize = AndroidInitializationSettings("ic_launcher");
    var iOSInitilize = IOSInitializationSettings();
    var initilizatioSettings =
        InitializationSettings(android: androidInitilize, iOS: iOSInitilize);
    flrtNotifications.initialize(initilizatioSettings,
        onSelectNotification: notificationSelected);

    showNotification();
    onInit(initScheduled: true);
  }

  Future onInit({bool initScheduled = false}) async {
    print('initScheduled $initScheduled');
    if (initScheduled) {
      tz.initializeTimeZones();
    }
  }

  void login() async {
    final a = await prefService.readCache();
    if (a != null) {
      print(a);
      Navigator.of(context).pushNamed('/homePage', arguments: {'name': a});
    } else {
      Navigator.of(context).pushNamed('/displayPage');
    }
  }

  Future showNotification() async {
    var androidDetails =
        new AndroidNotificationDetails("channelId", "channelName",
            channelDescription: "This is ME",
            // icon: '"@mipmap/ic_launcher"',
            importance: Importance.max);
    var iOSDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSDetails);

    flrtNotifications.zonedSchedule(
      // 0,
      Random().nextInt(1000),
      "सावधान !",
      "सिर्फ १० मिनट के बाद आपको सत्त्वमेव जयते आंदोलन की सात्विक प्रार्थना में जुड़ना है ।",
      _scheduleDaily(Time(15, 20)), //acc  to utc
      generalNotificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    // flrtNotifications.zonedSchedule(
    //   // 0,
    //   Random().nextInt(1000),
    //   "सावधान !",
    //   "सिर्फ १० मिनट के बाद आपको सत्त्वमेव जयते आंदोलन की सात्विक प्रार्थना में जुड़ना है ।",
    //   _scheduleDaily(Time(19, 52)), //acc  to utc
    //   generalNotificationDetails,
    //   androidAllowWhileIdle: true,
    //   uiLocalNotificationDateInterpretation:
    //       UILocalNotificationDateInterpretation.absoluteTime,
    //   matchDateTimeComponents: DateTimeComponents.time,
    // );

    flrtNotifications.zonedSchedule(
      // 1,
      Random().nextInt(1000),
      "सावधान !",
      "सिर्फ १० मिनट के बाद आपको सत्त्वमेव जयते आंदोलन की सात्विक प्रार्थना में जुड़ना है ।",
      _scheduleDaily(Time(3, 20)), //acc  to utc
      generalNotificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future notificationSelected(String? payload) async {
    Navigator.of(context).pushNamed('/splash');
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    print("Wait here");
    print(tz.local.timeZone);
    print(tz.Location);
    print(tz.local.currentTimeZone);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(Duration(days: 1))
        : scheduledDate;
  }
}
