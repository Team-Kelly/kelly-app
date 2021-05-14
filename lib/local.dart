import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  FlutterLocalNotificationsPlugin  _flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    //초기화
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();

    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  //메시지 클릭 시 이벤트
  Future<void> onSelectNotification(String payload) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Notification Payload'),
          content: Text('Payload: $payload'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('local noti exam'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: showNotification,
              child: Text('Show Notification'),
            ),
            ElevatedButton(
              onPressed: _dailyAtTimeNotification,
              child: Text('Daily At Time Notification'),
            ),
            ElevatedButton(
              onPressed: _repeatNotification,
              child: Text('Repeat Notification'),
            ),
            ElevatedButton(
              onPressed: () => _flutterLocalNotificationsPlugin.cancelAll(),
              child: Text('알람 모두 삭제'),
            ),
            Text("${TimeOfDay.now().hour.toString()}:${TimeOfDay.now().minute.toString()}")
          ],
        ),
      ),
    );
  }
  
  //기본 Notification
  Future<void> showNotification() async {
    var android = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var ios = IOSNotificationDetails();

    var detail = NotificationDetails(android: android, iOS: ios);

    await _flutterLocalNotificationsPlugin.show(
      0,
      '날씨 정보',
      '알아서 찾아보세요ㅋ',
      detail,
      payload: 'Hello Flutter',
    );
  }

  //지정 Notification
  Future<void> _dailyAtTimeNotification() async {
    var time = Time(2, 6, 0);

    var android = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var ios = IOSNotificationDetails();

    var detail = NotificationDetails(android: android, iOS: ios);

    await _flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      '매일 똑같은 시간의 Notification',
      '매일 똑같은 시간의 Notification 내용',
      time,
      detail,
      payload: 'Hello Flutter',
    );
  }

  //반복 Notification
  Future<void> _repeatNotification() async {

    var android = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var ios = IOSNotificationDetails();

    var detail = NotificationDetails(android: android, iOS: ios);

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      '반복 Notification',
      '반복 Notification 내용',
      RepeatInterval.everyMinute,
      detail,
      payload: 'Hello Flutter',
    );
  }
 }