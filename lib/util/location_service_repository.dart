import 'package:background_locator/location_dto.dart';
import 'dart:isolate';
import 'dart:async';
import 'dart:ui';

import 'package:flutter_tts/flutter_tts.dart';

class LocationServiceRepository {
  static final LocationServiceRepository _instance = LocationServiceRepository._();

  LocationServiceRepository._();

  factory LocationServiceRepository() {
    return _instance;
  }

  static const String isolateName = 'LocatorIsolate';

  static Future<void> init(Map<dynamic, dynamic> params) async {
    final SendPort send = IsolateNameServer.lookupPortByName(isolateName) as SendPort;
    send.send(null);
  }

  static Future<void> dispose() async {
    final SendPort send = IsolateNameServer.lookupPortByName(isolateName) as SendPort;
    send.send(null);
  }

  static Future<void> callback(LocationDto locationDto) async {
    final SendPort send = IsolateNameServer.lookupPortByName(isolateName) as SendPort;
    send.send(locationDto);
  }
}
