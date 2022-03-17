import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Noti {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationDetails android = const AndroidNotificationDetails(
      'id', 'notiChannel',
      importance: Importance.max,
      priority: Priority.max);
  IOSNotificationDetails ios = const IOSNotificationDetails();

  late NotificationDetails detail =
      NotificationDetails(android: android, iOS: ios);

  Future<void> init() async {
    AndroidInitializationSettings initSettingsAndroid =
        const AndroidInitializationSettings('dog');
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
      // onSelectNotification: (_)async{await tts.speak('알람이 클릭되었습니다.');}
    );
    // detail =
    //     NotificationDetails(android: android, iOS: ios);
  }

  Future<void> alert(int id, String ment) async {
    await flutterLocalNotificationsPlugin.show(
        id,
        '시작이 반이다',
        ment,
        const NotificationDetails(
            android: AndroidNotificationDetails(
              'ChannelID',
              'TTS 알림',
              importance: Importance.max,
              priority: Priority.max,
              playSound: true,
              icon: 'dog'
            ),
            iOS: IOSNotificationDetails()));
  }
}