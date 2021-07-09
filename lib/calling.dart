import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<WeatherAlarm> fetchWeather(String location) async {
  final http.Response response = await http.get(
    Uri.parse('http://222.112.225.80:8081/category/weather/' + '$location'),
  ); //http.get을 통해 서버를 로드

  if (response.statusCode == 200) {
    return WeatherAlarm.fromJson(
        jsonDecode(response.body)); //jsonDecode로 클래스에 값을 전달
  } else {
    throw Exception('Loading data...');
  }
}

class WeatherAlarm {
  String currentLocation;
  String currentTemper;
  String minTemper;
  String maxTemper;
  String curDust;
  String curUltraDust;

  WeatherAlarm(
      {required this.currentLocation,
      required this.currentTemper,
      required this.minTemper,
      required this.maxTemper,
      required this.curDust,
      required this.curUltraDust});

  factory WeatherAlarm.fromJson(Map<String, dynamic> json) {
    return WeatherAlarm(
        currentLocation: json['currentLocation'],
        currentTemper: json['currentTemper'],
        minTemper: json['minTemper'],
        maxTemper: json['maxTemper'],
        curDust: json['curDust'],
        curUltraDust: json['curUltraDust']);
  } //json파일로부터 값을 전달받아 알람 클래스의 생성자 호출
} //알람 정보를 저장하는 클래스

Future<BusAlarm> fetchBus(String routeID, String busStationID, String direction) async {
  final http.Response response = await http.get(
    Uri.parse('http://222.112.225.80:8081/category/bus/$routeID/$busStationID/$direction'),
  ); //http.get을 통해 서버를 로드

  if (response.statusCode == 200) {
    return BusAlarm.fromJson(
        jsonDecode(response.body)); //jsonDecode로 클래스에 값을 전달
  } else {
    throw Exception('Loading data...');
  }
}

class BusAlarm {
  String firstArr;
  String secondArr;

  BusAlarm({required this.firstArr, required this.secondArr});

  factory BusAlarm.fromJson(Map<String, dynamic> json) {
    return BusAlarm(firstArr: json['firstArr'], secondArr: json['secondArr']);
  } //json파일로부터 값을 전달받아 알람 클래스의 생성자 호출
} //알람 정보를 저장하는 클래스
