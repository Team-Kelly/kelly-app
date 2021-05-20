import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'calling.dart' as call;
import 'calling.dart';

class AppNoti implements Noti {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //localNoti 생성자 호출

  AndroidNotificationDetails android = AndroidNotificationDetails(
      'id', 'notiTitle', 'notiDesc',
      importance: Importance.max,
      priority: Priority.max,
      styleInformation: BigTextStyleInformation(
          '날씨도\n좋은데\n집에서\n과제나\n해야지\nㅠㅠㅠ')); //안드로이드 세부설정에 관한 생성자 호출
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
        //if (Platform.isIOS) {}
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

        flutterLocalNotificationsPlugin.initialize(initSettings,
            onSelectNotification: onSelectNotification);
        detail = NotificationDetails(
            android: android, iOS: ios); //플랫폼 별 세부설정에 관한 생성자 호출
        return;
      });

  Future<void> weatherAlert(id, hour, minute, info, location) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    WeatherAlarm weatherAlarm = await call.fetchWeather(location);
    await this.flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "$info",
        "현재 온도 : ${weatherAlarm.currentTemper}\n최고 기온 : ${weatherAlarm.maxTemper}\n최저 기온 : ${weatherAlarm.minTemper}",
        scheduledDate,
        this.detail,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime
        //표준시간대 기준 or 기기 내의 사간 기준인지 설정
        );
  }

  Future<void> busAlert(id, hour, minute, info, routeID, busStationID, direction) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    BusAlarm busAlarm = await call.fetchBus(routeID, busStationID, direction);
    await this.flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "$info",
        "${busAlarm.firstArr}\n${busAlarm.secondArr}",
        scheduledDate,
        this.detail,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime
        //표준시간대 기준 or 기기 내의 사간 기준인지 설정
        );
  }

  Future<void> onSelectNotification(String payload) async {}
}

abstract class Noti {
  Future<bool> init();
  Future<void> weatherAlert(id, hour, minute, info, location);
  Future<void> busAlert(id, hour, minute, info, routeID, busStationID, direction);
}
