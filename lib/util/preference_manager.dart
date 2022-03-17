import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/util/route.dto.dart';
import 'package:app/util/route.vo.dart';
import 'package:flutter/widgets.dart';

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
    await _loadAlarmFromPrefs();
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
    required String name,
    required DateTime time,
    required List<bool> dotw,
    required PathNodeList pathNodeList,
  }) async {
    checkInit();

    debugPrint("$LOG Create Start");

    _alarmList.add(
        Alarm(name: name, time: time, dotw: dotw, pathNodeList: pathNodeList));
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
    required String name,
    required DateTime time,
    required PathNodeList pathNodeList,
    required List<bool> dotw,
  }) async {
    checkInit();
    debugPrint("$LOG Update start");

    if (_alarmList.length <= index) throw Exception("$LOG index out of range");

    _alarmList[index] =
        Alarm(name: name, time: time, dotw: dotw, pathNodeList: pathNodeList);

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
  Future<void> deleteAllAlarm() async {
    checkInit();
    debugPrint("$LOG Delete all start");

    await resetPrefs();
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
  Future<void> resetPrefs() async {
    checkInit();
    debugPrint("$LOG Reset start");
    await _prefs.remove("alarmNames");
    await _prefs.remove("alarmTimes");
    await _prefs.remove("alarmDOTWs");
    await _prefs.remove("pathNodeLists");
    _alarmList.clear();
    debugPrint("$LOG Reset done.");
  }

  /// ### Load Alarm From Preferences
  ///  - shared preferences 데이터를 List<Alarm> 데이터로 변환 및 저장
  Future<List<Alarm>> _loadAlarmFromPrefs() async {
    checkInit();
    debugPrint("$LOG Load alarm from prefs start");

    List<String> alarmNames = _prefs.getStringList("alarmNames") ?? [];
    List<String> alarmTimes = _prefs.getStringList("alarmTimes") ?? [];
    List<String> alarmDOTWs = _prefs.getStringList("alarmDOTWs") ?? [];
    List<String> pathNodeLists = _prefs.getStringList("pathNodeLists") ?? [];

    debugPrint("$LOG $alarmNames");
    debugPrint("$LOG $alarmTimes");
    debugPrint("$LOG $alarmDOTWs");
    debugPrint("$LOG $pathNodeLists");

    // 데이터 무결성 검사
    if (alarmTimes.length != alarmDOTWs.length &&
        alarmTimes.length != alarmNames.length &&
        alarmTimes.length != pathNodeLists.length) {
      throw Exception("$LOG prefs. data was corrupted\nPlease reset prefs.");
    }

    // 캐싱 데이터 초기화
    _alarmList.clear();

    // 데이터 추가
    for (int i = 0; i < alarmTimes.length; i++) {
      // DOTW -> List<bool>
      List<bool> alarmDOTW = [];

      for (String e in alarmDOTWs[i].split(",")) {
        alarmDOTW.add(e.trim() == "true");
      }

      // pathNodeLists -> PathNodeList
      PathNodeList pathNodeList =
          (await RouteDTO.get(raw: "[${pathNodeLists[i]}]"))[0];

      _alarmList.add(Alarm(
          name: alarmNames[i],
          time: DateTime.parse(alarmTimes[i]),
          dotw: alarmDOTW,
          pathNodeList: pathNodeList));
    }

    debugPrint("$LOG Load alarm from prefs done.");

    return _alarmList;
  }

  /// ### Save Alarm To Preferences
  ///  - List<Alarm>을 shared preferences에 변환 및 저장
  Future<void> _saveAlarmToPrefs(List<Alarm> alarmList) async {
    checkInit();
    List<String> alarmNames = [];
    List<String> alarmTimes = [];
    List<String> alarmDOTWs = [];
    List<String> pathNodeLists = [];

    for (Alarm i in alarmList) {
      alarmNames.add(i.alarmName.toString());
      alarmTimes.add(i.alarmTime.toString());
      alarmDOTWs.add(i.alarmDOTW
          .toString()
          .substring(1, i.alarmDOTW.toString().length - 1));
      pathNodeLists.add(i.pathNodeList.toString());
    }

    await _prefs.setStringList("alarmNames", alarmNames);
    await _prefs.setStringList("alarmTimes", alarmTimes);
    await _prefs.setStringList("alarmDOTWs", alarmDOTWs);
    await _prefs.setStringList("pathNodeLists", pathNodeLists);
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

  /// ### 저장된 경로
  late PathNodeList _pathNodeList;

  /// ### 알람 이름
  String _alarmName = "";

  Alarm({
    required String name,
    required DateTime time,
    required List<bool> dotw,
    required PathNodeList pathNodeList,
  }) {
    alarmTime = time;
    alarmDOTW = dotw;
    this.pathNodeList = pathNodeList;
    alarmName = name;
  }

  String get alarmName => _alarmName;
  DateTime get alarmTime => _alarmTime;
  List<bool> get alarmDOTW => _alarmDOTW;
  PathNodeList get pathNodeList => _pathNodeList;

  set alarmName(String inp) => _alarmName = inp;
  set alarmTime(DateTime inp) => _alarmTime = inp;
  set alarmDOTW(List<bool> inp) {
    if (inp.length != 7) throw Exception("dotw length must be 7.");
    _alarmDOTW = inp;
  }

  set pathNodeList(PathNodeList inp) {
    _pathNodeList = inp;
  }

  @override
  String toString() {
    return "{\"alarmName\": \"$alarmName\", \"alarmTime\": \"$alarmTime\", \"alarmDOTW\": $alarmDOTW, \"pathNodeList\": $pathNodeList}";
  }
}
