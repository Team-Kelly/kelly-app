import 'package:background_locator/location_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'location_service_repository.dart';
import 'dart:async';

class LocationCallbackHandler {
  static Future<void> initCallback(Map<dynamic, dynamic> params) async {
    print("-=-=-=-=-=-=-= init locator -=-=-=-=-=-=-=-=-=");
    await LocationServiceRepository.init(params);
  }

  static Future<void> disposeCallback() async {
    await LocationServiceRepository.dispose();
  }

  static Future<void> callback(LocationDto locationDto) async {
    print("-=-=-=-=-=-=-= callback -=-=-=-=-=-=-=-=-=");
    FlutterTts tts = FlutterTts();
    tts.speak('위치가 변경되었습니다.');
    print('callback');
    await LocationServiceRepository.callback(locationDto);
  }

  static Future<void> notificationCallback() async {
    print("-=-=-=-=-=-=-= noti -=-=-=-=-=-=-=-=-=");
    print('***notificationCallback');
  }

  void alarmTimer() {
    int nowHour = TimeOfDay.now().hour;
    int nowminute = TimeOfDay.now().minute;
  }
}
