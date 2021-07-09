import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'calling.dart';
//import 'dart:isolate';

//FlutterTts tts = FlutterTts();

class AppNoti implements Noti {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //localNoti 생성자 호출

  AndroidNotificationDetails android = AndroidNotificationDetails(
      'id', 'notiChannel', 'notiDesc',
      importance: Importance.max,
      priority: Priority.max); //안드로이드 세부설정에 관한 생성자 호출
  IOSNotificationDetails ios = IOSNotificationDetails(); //IOS 세부설정에 관한 생성자 호출

  late NotificationDetails detail =
      NotificationDetails(android: android, iOS: ios); //플랫폼 별 세부설정에 관한 변수 선언

  Future<void> init() async {
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

    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      //onSelectNotification: onSelectNotification
    );
    // detail =
    //     NotificationDetails(android: android, iOS: ios); //플랫폼 별 세부설정에 관한 생성자 호출
  }

  Future<void> weatherAlert(id, hour, minute, info, location) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    WeatherAlarm weatherAlarm = await fetchWeather(location);

    await this.flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "$info",
        "현재 온도 : ${weatherAlarm.currentTemper}\n최고 기온 : ${weatherAlarm.maxTemper}\n최저 기온 : ${weatherAlarm.minTemper}",
        scheduledDate,
        NotificationDetails(
            android: AndroidNotificationDetails(
              id.toString(), 'notiChannel', 'notiDesc',
              importance: Importance.max,
              priority: Priority.max,
              playSound: true,
              sound: RawResourceAndroidNotificationSound('slackhi'),
              //sound:UriAndroidNotificationSound('/storage/emulated/0/Android/data/com.kelly.kelly/files/hello.mp3'),
            ),
            iOS: IOSNotificationDetails(sound: 'slackhi')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime
        //표준시간대 기준 or 기기 내의 사간 기준인지 설정
        );
  }

  Future<void> busAlert(
      id, hour, minute, info, routeID, busStationID, direction) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    BusAlarm busAlarm = await fetchBus(routeID, busStationID, direction);
    await this.flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "$info",
        "${busAlarm.firstArr}\n${busAlarm.secondArr}",
        scheduledDate,
        NotificationDetails(
            android: AndroidNotificationDetails(
              id.toString(), 'notiChannel', 'notiDesc',
              importance: Importance.max,
              priority: Priority.max,
              playSound: true,
              sound: RawResourceAndroidNotificationSound('slackhi'),
              //sound:UriAndroidNotificationSound('/storage/emulated/0/Android/data/com.kelly.kelly/files/hello.mp3'),
            ),
            iOS: IOSNotificationDetails(sound: 'slackhi')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime
        //표준시간대 기준 or 기기 내의 사간 기준인지 설정
        );
  }

// Future<void> ttsAlert(id, hour, minute, title, text) async {
//     tz.initializeTimeZones();

//     await tts.synthesizeToFile('$text', 'android/app/src/main/res/raw/$title');
//     //https://zion830.tistory.com/51

//     tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
//     final now = tz.TZDateTime.now(tz.local);
//     var scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

//     await this.flutterLocalNotificationsPlugin.zonedSchedule(
//         id,
//         "$title",
//         "$text",
//         scheduledDate,
//         NotificationDetails(
//             android: AndroidNotificationDetails(
//                 id.toString(), 'notiChannel', 'notiDesc',
//                 importance: Importance.max,
//                 priority: Priority.max,
//                 playSound: true,
//                 sound: RawResourceAndroidNotificationSound('$title'),
//                 styleInformation: BigTextStyleInformation('n\nu\nl\nl\n!\n')),
//             iOS: IOSNotificationDetails(sound: '$title')),
//         //this.detail,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime
//         //표준시간대 기준 or 기기 내의 사간 기준인지 설정
//         );
//     //tts.speak('${weatherAlarm.currentTemper}');
//   }

//   Future<void> onSelectNotification(String payload) async {}
}

abstract class Noti {
  Future<void> init();
  Future<void> weatherAlert(id, hour, minute, info, location);
  Future<void> busAlert(
      id, hour, minute, info, routeID, busStationID, direction);
  //Future<void> ttsAlert(id, hour, minute, title, text);
}

//full screen alert : https://medium.com/android-news/full-screen-intent-notifications-android-85ea2f5b5dc1
