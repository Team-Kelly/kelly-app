import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class AppNoti implements Noti {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //localNoti 생성자 호출

  AndroidNotificationDetails android = AndroidNotificationDetails(
      'id', 'notiTitle', 'notiDesc',
      importance: Importance.max,
      priority: Priority.max); //안드로이드 세부설정에 관한 생성자 호출
  IOSNotificationDetails ios = IOSNotificationDetails(); //IOS 세부설정에 관한 생성자 호출

  NotificationDetails detail; //플랫폼 별 세부설정에 관한 변수 선언

  @override
  Future<bool> init() async => await Future(() async {
        PermissionStatus status =
            await Permission.notification.request(); //noti에 대한 권한 요청
        while (status.isDenied) {
          status = await Permission.notification.request();
          await openAppSettings();
        } //권한 요청이 거절될 경우
        if (Platform.isIOS) {}
        AndroidInitializationSettings initSettingsAndroid =
            AndroidInitializationSettings('app_icon'); //안드로이드 초기 세팅 설정
        IOSInitializationSettings initSettingsIOS = IOSInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
        ); //IOS 초기 세팅 설정
        InitializationSettings initSettings = InitializationSettings(
          android: initSettingsAndroid,
          iOS: initSettingsIOS,
        ); //OS별 초기 세팅 진행
        flutterLocalNotificationsPlugin.initialize(
          initSettings, /*onSelectNotification: onSelectNotification*/
        );
        detail = NotificationDetails(
            android: android, iOS: ios); //플랫폼 별 세부설정에 관한 생성자 호출
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(AndroidNotificationChannel(
              'high_importance_channel', // id
              'High Importance Notifications', // title
              'This channel is used for important notifications.', // description
              importance: Importance.high,
            ));
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(alert: true, badge: true, sound: true);
        return;
      });

  @override
  Future<void> show() async {
    this
        .flutterLocalNotificationsPlugin
        .show(1, "Alarm title", "Alarm contents", this.detail);
  }

  Future<void> alert(hour, minute) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    this.flutterLocalNotificationsPlugin.zonedSchedule(
        1, "날씨 알림", "local noti contents", scheduledDate, this.detail,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}

abstract class Noti {
  Future<bool> init();

  Future<void> show();
  Future<void> alert(hour, minute);
}
