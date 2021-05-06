import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class AppNoti implements Noti {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //localNoti 생성자 호출

  AndroidNotificationDetails android = AndroidNotificationDetails(
      'id', 'notiTitle', 'notiDesc',
      importance: Importance.max, priority: Priority.max); //안드로이드 설정
  IOSNotificationDetails ios = IOSNotificationDetails(); //IOS 설정
  NotificationDetails /*?*/ detail;

  static Future<void> backInit(RemoteMessage message) async {
    await Firebase.initializeApp(); //flutterfire 초기화
    print('Handling a background message ${message.messageId}');
    return;
  }

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
        flutterLocalNotificationsPlugin.initialize(initSettings);
        detail = NotificationDetails(android: android, iOS: ios);
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
      }).then((_) async {
        await Firebase.initializeApp();
        FirebaseMessaging.onBackgroundMessage(AppNoti.backInit);
        RemoteMessage /*?*/ r =
            await FirebaseMessaging.instance.getInitialMessage();
        print("INIT r : ${r ?? 'r'}");
        String /*?*/ token = await FirebaseMessaging.instance.getToken();
        print("token : ${token ?? 'token NULL!'}");
        if (Platform.isIOS) {
          await FirebaseMessaging.instance
              .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );
        }

        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          RemoteNotification /*?*/ notification = message.notification;
          AndroidNotification /*?*/ android = message.notification?.android;
          if (notification != null && android != null) {
            flutterLocalNotificationsPlugin.show(notification.hashCode,
                notification.title, notification.body, detail);
          }
        });
        FirebaseMessaging.onMessageOpenedApp
            .listen((RemoteMessage message) => print('ON_APP :$message'));
        return true;
      });

  @override
  Future<void> show() async => this
      .flutterLocalNotificationsPlugin
      .show(1, "p title", "p body", this.detail);
}

abstract class Noti {
  Future<bool> init();

  Future<void> show();
}
