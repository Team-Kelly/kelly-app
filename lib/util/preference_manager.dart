import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String LOG = "PrefManager:: ";

class PreferenceManager {
  // Singleton
  PreferenceManager._();
  static final PreferenceManager _instance = PreferenceManager._();
  static PreferenceManager get instance => _instance;

  late SharedPreferences _prefs;
  final List<Alarm> _alarmList = [];
  bool _isInit = false;

  // 초기화
  Future<void> init() async {
    debugPrint("$LOG init.");
    _isInit = true;
    _prefs = await SharedPreferences.getInstance();
    _loadAlarmFromPrefs();
    debugPrint("$LOG AlarmList: ${readAlarm()}");
    debugPrint("$LOG init done.");
  }

  ///
  ///
  ///
  ///
  // CRUD

  /// ### CREATE
  Future<void> createAlarm({
    required DateTime time,
    required List<bool> dotw,
  }) async {
    checkInit();

    debugPrint("$LOG Create Start");

    _alarmList.add(Alarm(time: time, dotw: dotw));
    await _saveAlarmToPrefs(_alarmList);

    debugPrint("$LOG Create End");
  }

  ///
  /// ### READ
  List<Alarm> readAlarm() => _alarmList;

  ///
  /// ### UPDATE
  Future<void> updateAlarm({
    required int index,
    required DateTime time,
    required List<bool> dotw,
  }) async {
    checkInit();
    debugPrint("$LOG Update start");

    if (_alarmList.length <= index) throw Exception("$LOG index out of range");

    _alarmList[index] = Alarm(time: time, dotw: dotw);

    await _saveAlarmToPrefs(_alarmList);

    debugPrint("$LOG Update done");
  }

  ///
  /// ### DELETE
  Future<void> deleteAlarm({
    required int index,
  }) async {
    checkInit();
    debugPrint("$LOG Delete start");

    if (_alarmList.length <= index) throw Exception("$LOG index out of range");

    _alarmList.removeAt(index);

    await _saveAlarmToPrefs(_alarmList);

    debugPrint("$LOG Delete done");
  }

  ///
  /// ### DELETE ALL
  void deleteAllAlarm() {
    checkInit();
    debugPrint("$LOG Delete all start");

    resetPrefs();
    _alarmList.clear();

    debugPrint("$LOG Delete all done");
  }

  ///
  ///
  ///
  ///
  // 기타 함수

  /// ### Reset Preferences
  ///  - shared preferences 값 초기화
  resetPrefs() async {
    checkInit();
    debugPrint("$LOG Reset start");
    await _prefs.remove("alarmTimes");
    await _prefs.remove("alarmDOTWs");
    _alarmList.clear();
    debugPrint("$LOG Reset done.");
  }

  /// ### Load Alarm From Preferences
  ///  - shared preferences 데이터를 List<Alarm> 데이터로 변환 및 저장
  List<Alarm> _loadAlarmFromPrefs() {
    checkInit();
    debugPrint("$LOG Load alarm from prefs start");

    List<String> alarmTimes = _prefs.getStringList("alarmTimes") ?? [];
    List<String> alarmDOTWs = _prefs.getStringList("alarmDOTWs") ?? [];

    debugPrint("$LOG $alarmTimes");
    debugPrint("$LOG $alarmDOTWs");

    if (alarmTimes.length != alarmDOTWs.length) {
      throw Exception("$LOG prefs. data was corrupted\nPlease reset prefs.");
    }

    _alarmList.clear();

    for (int i = 0; i < alarmTimes.length; i++) {
      List<bool> alarmDOTW = [];
      for (String e in alarmDOTWs[i].split(",")) {
        alarmDOTW.add(e == "true");
      }

      _alarmList
          .add(Alarm(dotw: alarmDOTW, time: DateTime.parse(alarmTimes[i])));
    }

    debugPrint("$LOG Load alarm from prefs done.");

    return [];
  }

  /// ### Save Alarm To Preferences
  ///  - List<Alarm>을 shared preferences에 변환 및 저장
  Future<void> _saveAlarmToPrefs(List<Alarm> alarmList) async {
    checkInit();
    List<String> alarmTimes = [];
    List<String> alarmDOTWs = [];

    for (Alarm i in alarmList) {
      alarmTimes.add(i.alarmTime.toString());
      alarmDOTWs.add(i.alarmDOTW
          .toString()
          .substring(1, i.alarmDOTW.toString().length - 1));
    }

    await _prefs.setStringList("alarmTimes", alarmTimes);
    await _prefs.setStringList("alarmDOTWs", alarmDOTWs);
  }

  /// ### Check Init
  ///  - 초기화 상태 확인
  ///  - init() 함수 호출 여부 확인
  void checkInit() {
    if (!_isInit) {
      throw Exception("Please init() before use PreferenceManager.");
    }
  }
}

///
///
///
class Alarm {
  /// ### 알람 울릴 시간
  DateTime _alarmTime = DateTime(0, 0, 0, 0, 0);

  /// ### 울릴 요일 (Day of the weeek)
  /// `일,월,화,수,목,금,토` 순서
  List<bool> _alarmDOTW = [false, false, false, false, false, false, false];

  Alarm({required DateTime time, required List<bool> dotw}) {
    alarmTime = time;
    alarmDOTW = dotw;
  }

  DateTime get alarmTime => _alarmTime;
  List<bool> get alarmDOTW => _alarmDOTW;

  set alarmTime(DateTime inp) => _alarmTime = inp;
  set alarmDOTW(List<bool> inp) {
    if (inp.length != 7) throw Exception("dotw length must be 7.");
    _alarmDOTW = inp;
  }

  @override
  String toString() {
    return "{alarmTime: $alarmTime, alarmDOTW: $alarmDOTW}";
  }
}
