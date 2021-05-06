import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<Alarm> createAlarm(String timer, String appToken) async {
  final http.Response response = await http.post(
    Uri.parse('http://kelly.doky.space:8081/test'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      "timer": timer,
      "appToken":appToken
    }), //jsonEncode로 서버에 추가할 json파일 생성 후 post
  );


  if (response.statusCode == 200) {
    return Alarm.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create alarm. CODE:${response.statusCode}');
  }
}

class Alarm {
  final String timer;
  final String appToken;

  Alarm({this.timer, this.appToken});

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      timer: json['timer'],
      appToken: json['appToken'],
    );
  } //json파일로부터 값을 전달받아 클래스에 저장
} //알람 정보를 저장할 클래스,
