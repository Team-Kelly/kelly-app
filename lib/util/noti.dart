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
              'ChannelName',
              importance: Importance.max,
              priority: Priority.max,
              playSound: true,
            ),
            iOS: IOSNotificationDetails()));
  }

  Future<void> disposableAlert(int id, int hour, int minute) async {
    initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        '예약 알림',
        '예약알림입니다.',
        TZDateTime(
            getLocation('Asia/Seoul'),
            TZDateTime.now(getLocation('Asia/Seoul')).year,
            TZDateTime.now(getLocation('Asia/Seoul')).month,
            TZDateTime.now(getLocation('Asia/Seoul')).day,
            hour,
            minute),
        const NotificationDetails(
            android: AndroidNotificationDetails(
              'ChannelID',
              '출근 알림',
              importance: Importance.max,
              priority: Priority.max,
              playSound: true,
            ),
            iOS: IOSNotificationDetails()),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

//   Future<void> weeklyAlert(int id, int hour, int minute) async{
//   await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
//     id,
//     'title', 'body', Day(0), Time(hour, minute),
//     // TZDateTime(
//     //         getLocation('Asia/Seoul'),
//     //         TZDateTime.now(getLocation('Asia/Seoul')).year,
//     //         TZDateTime.now(getLocation('Asia/Seoul')).month,
//     //         TZDateTime.now(getLocation('Asia/Seoul')).,
//     //         hour,
//     //         minute),
//         const NotificationDetails(
//             android: AndroidNotificationDetails(
//               'ChannelID',
//               '출근 알림',
//               importance: Importance.max,
//               priority: Priority.max,
//               playSound: true,
//             ),
//             iOS: IOSNotificationDetails()
//             );))
//         // uiLocalNotificationDateInterpretation:
//         //     UILocalNotificationDateInterpretation.absoluteTime,
//         // androidAllowWhileIdle: true);)

// }
}
