import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Alarm> fetchAlarm() async {
  final response = await http.get(
    Uri.parse('http://222.112.225.80:8081/test'),
  );  //http.get을 통해 서버를 로드

  if (response.statusCode == 200) {
    return Alarm.fromJson(jsonDecode(response.body)); //jsonDecode로 클래스에 값을 전달
  } else {
    throw Exception('Failed to load alarm');
  }
}

Future<Alarm> updateAlarm(String timer, /*String appToken*/) async {
  final http.Response response = await http.put(
    Uri.parse('http://222.112.225.80:8081/test'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'timer': timer,
      /*'appToken': appToken*/
    }), //jsonEncode로 서버에 업데이트할 json파일 생성
  );  //http.put을 통해 서버에 업데이트

  if (response.statusCode == 200) {
    return Alarm.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update alarm.');
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