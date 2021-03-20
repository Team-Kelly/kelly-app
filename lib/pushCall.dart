import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
dynamic myToken = ' ';

void printMyToken() async {}

void initState() {
  initState();

  _firebaseMessaging.getToken().then((value) {
    myToken = value;
  });

  while (myToken == ' ') {
    Future.delayed(Duration(milliseconds: 1000));
  }

  // myToken = await _firebaseMessaging.getToken();

  printMyToken();
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
    },
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    },
  );
  _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true));
  _firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
    print("Settings registered: $settings");
  });
  _firebaseMessaging.getToken().then((String token) {
    assert(token != null);
  });
}

void pushNoti() async {
  var serverToken =
      'AAAA5SFmgg8:APA91bFcpvDL9Es-i3lBlGtKfYCeXlXFreLcnK1dW20axkqRSvJGP1y51hdu-TM0V4C-p-ZAB5E8Zfjv6-02MXDZhYi22cftvpnVwVDJD4SjQE0L6vv22OZhKmN3s8i5nwE2Tt8Lg-tj';

  await http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverToken',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': 'this is a body',
          'title': 'this is a title'
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done'
        },
        'to': myToken,
      },
    ),
  );
}
