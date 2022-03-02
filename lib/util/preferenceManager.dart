import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

String LOG = "PrefManager:: ";

class PreferenceManager {
  // _(implicit) Named Constructor
  // 추후 Named Constructor 중복 방지
  // https://stackoverflow.com/questions/57878112/a-class-method-named-function-in-dart/57878228
  PreferenceManager._();
  static PreferenceManager _instance = PreferenceManager._();
  static PreferenceManager get instance => _instance;

  late SharedPreferences _prefs;

  // ignore: non_constant_identifier_names
  final String USERNAME = "users";

  ///
  ///
  ///
  ///
  ///
  // Def.
  bool _isVibration = true;

  ///
  ///
  ///
  ///
  ///
  // Getter
  bool get isVibration => _isVibration;

  ///
  ///
  ///
  ///
  ///
  // Setter

  ///
  // CREATE
  void createDevice({
    required String uuid,
    required String name,
    required String imgUrl,
    int speedPreset = 40,
    bool isSilence = false,
  }) {
    debugPrint("$LOG Create Start");

    // _prefs.setString(
    //   "$USERNAME.ddd",
    //   json.encode(
    //     _ddd,
    //     toEncodable: (object) => {
    //       dd.toString(): object[dd],
    //     },
    //   ),
    // );

    debugPrint("$LOG Create End");
  }

  ///
  // READ
  // 함수 제작

  ///
  // UPDATE
  void updateDevice({
    required String uuid,
    String? name,
    String? imgUrl,
    bool? isSilence,
    int? speedPreset,
  }) {
    debugPrint("$LOG Update Start");

    // _prefs.setString(
    //   "$USERNAME.ddd",
    //   json.encode(
    //     _ddd,
    //     toEncodable: (object) => {
    //       dd.toString(): object[dd],
    //     },
    //   ),
    // );

    debugPrint("$LOG Update End");
  }

  ///
  // DELETE
  void deleteDevice({required String uuid}) {
    debugPrint("$LOG Delete Start");

    // _prefs.setString(
    //   "$USERNAME.ddd",
    //   json.encode(
    //     _ddd,
    //     toEncodable: (object) => {
    //       dd.toString(): object[dd],
    //     },
    //   ),
    // );

    debugPrint("$LOG Delete End");
  }

  ///
  ///
  ///

  // set isWakeLock(bool inp) {
  //   _isWakeLock = inp;
  //   _prefs.setBool("$USERNAME.isWakeLock", _isWakeLock);
  // }

  ///
  ///
  ///
  ///
  ///
  // Functions.

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    debugPrint("$LOG Load Start");
    String? tmpDeviceData = _prefs.getString("$USERNAME.deviceData");
    debugPrint("$LOG $tmpDeviceData");

    //

    // debugPrint("$LOG - _isMetric: $_isMetric");
    // debugPrint("$LOG - _isWakeLock: $_isWakeLock");
  }

  Future<void> resetAll() async {}
}
