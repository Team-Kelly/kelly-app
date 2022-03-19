import 'package:background_locator/location_dto.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:proj4dart/proj4dart.dart';
import 'location_service_repository.dart';
import 'package:app/util/wment.dto.dart';
import 'package:app/util/wment.vo.dart';
import 'package:app/util/noti.dart';
import 'dart:convert';
import 'dart:async';

Noti noti = Noti();

class LocationCallbackHandler {
  static String result = '';

  static Future<void> initCallback(Map<dynamic, dynamic> params) async {
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    await myLocationCallbackRepository.init(params);
    result = params['pref'];
    // List<dynamic> alarms = jsonDecode(result);
    // for (int i = 0; i<alarms.length;i++){
    //   print(alarms[i]['alarmName']);
    // }
  }

  static Future<void> disposeCallback() async {
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    await myLocationCallbackRepository.dispose();
  }

  static Future<void> callback(LocationDto locationDto) async {
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    FlutterTts tts = FlutterTts();
    Noti noti = Noti();

    await tts.setVolume(1);
    List<dynamic> alarms = jsonDecode(result);
    int weekday = DateTime.now().weekday;
    weekday = weekday == 7 ? 0 : weekday;

    for (int i = 0; i < alarms.length; i++) {
      if (alarms[i]['alarmDOTW'][weekday]) {
        DateTime now = DateTime.now();
        int alarmHour =
            int.parse(alarms[i]['alarmTime'].split(' ')[1].split(':')[0]);
        int alarmMinute =
            int.parse(alarms[i]['alarmTime'].split(' ')[1].split(':')[1]);
        if (now.hour == alarmHour && now.minute == alarmMinute) {
          //  알람 동작
          if (!isTTSRunning) {
            isTTSRunning = true;

            int hour = DateTime.now().hour;
            hour = hour > 12 ? hour - 12 : hour;

            WeatherMentionVO mention = await WeatherMentionDTO.get(
                location:
                    Point(x: locationDto.latitude, y: locationDto.longitude));
            await noti.alert((now.hour + now.minute), mention.prop[0]);
            // TTS 멘트
            // await tts.speak(mention.prop[0]);
            // await Future.delayed(
            //     Duration(milliseconds: mention.prop[0].length * 150));
            // await tts.speak("현재 시간은 $hour시 ${DateTime.now().minute}분입니다.");
            // await Future.delayed(const Duration(milliseconds: 3000));

            await tts.speak(mention.prop[0]);
            await Future.delayed(
                Duration(milliseconds: mention.prop[0].length * 150));
            await tts.speak("현재 시간은 $hour시 ${DateTime.now().minute}분입니다.");
            await Future.delayed(const Duration(seconds: 60));
            // 두 번만 울리게 임의 수정

            isTTSRunning = false;
          }
        }
      }
    }
    await myLocationCallbackRepository.callback(locationDto);
  }

  static bool isTTSRunning = false;

  static Future<void> notificationCallback() async {
    // print('***notificationCallback');
  }
}
