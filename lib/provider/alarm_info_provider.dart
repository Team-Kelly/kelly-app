import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AlarmInfo extends ChangeNotifier {
  Map<String, Alarm> alarms = {};
}

class Alarm {
  late String key;
  late int year;
  late int month;
  late int day;
  late int hour;
  late int minute;

  Alarm(
      {required this.key,
      required this.year,
      required this.month,
      required this.day,
      required this.hour,
      required this.minute});
}
