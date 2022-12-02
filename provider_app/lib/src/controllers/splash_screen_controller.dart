import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:handy/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/i18n.dart';
import '../repository/settings_repository.dart' as settingRepo;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
class SplashScreenController extends ControllerMVC with ChangeNotifier {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState> scaffoldKey;

  SplashScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // Should define these variables before the app loaded
    progress.value = {"Setting": 0, "User": 0};
  }

  @override
  void initState() {


    settingRepo.setting.addListener(() {
      progress.value["Setting"] = 41;
      progress.value["User"] = 59;
      print('success');
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      progress?.notifyListeners();
    });
    Timer(Duration(seconds: 20), () {
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.current.verify_your_internet_connection),
      ));
    });

    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,

            NotificationDetails(
              android: AndroidNotificationDetails(
                'your channel id',
                setting.value.appName,
                'your channel description',
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: '@mipmap/ic_launcher',
                enableVibration: true,
                priority: Priority.high,
                playSound: true,
                importance: Importance.max,
                sound: RawResourceAndroidNotificationSound('notification'),

              ),

            ), payload: 'item x');
      }


    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        /** Navigator.pushNamed(context, '/message',
            arguments: MessageArguments(message, true)); */
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      /**  Navigator.pushNamed(context, '/message',
          arguments: MessageArguments(message, true)); */
    });
  }
}
