import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

class Noti {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationDetails android = const AndroidNotificationDetails(
      'id', 'notiChannel',
      importance: Importance.max, priority: Priority.max);
  IOSNotificationDetails ios = const IOSNotificationDetails();

  late NotificationDetails detail =
      NotificationDetails(android: android, iOS: ios);

  Future<void> init() async {
    AndroidInitializationSettings initSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    IOSInitializationSettings initSettingsIOS = const IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    InitializationSettings initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      //onSelectNotification: onSelectNotification
    );
    // detail =
    //     NotificationDetails(android: android, iOS: ios);
  }

  Future<void> alert() async {
    await flutterLocalNotificationsPlugin.show(
        1,
        '기본 알림',
        '기본알림입니다.',
        const NotificationDetails(
            android: AndroidNotificationDetails(
              'ChannelID',
              '출근길 알림',
              importance: Importance.max,
              priority: Priority.max,
              playSound: true,
            ),
            iOS: IOSNotificationDetails()));
  }
}
