import 'dart:isolate';

import 'dart:ui';

import 'package:app/provider/personal_info_provider.dart';
import 'package:app/util/location_callback_handler.dart';
import 'package:app/util/preference_manager.dart';
import 'package:app/util/utils.dart';
import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart' as location;

import '../../util/location_service_repository.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  ReceivePort port = ReceivePort();

  late bool isRunning;
  late LocationDto lastLocation;

  @override
  void initState() {
    runner();

    super.initState();
  }

  Future<void> initPlatformState() async {
    await BackgroundLocator.initialize();
  }

  Future<bool> checkLocationOn() async {
    // GPS or Location을 사용자가 켜도록 반복적으로 Dialog 띄움.
    location.Location loc = location.Location();
    bool _isServiceEnabled = false;
    _isServiceEnabled = await loc.serviceEnabled();

    while (!_isServiceEnabled) {
      await loc.requestService();
      _isServiceEnabled = await loc.serviceEnabled();
    }

    return true;
  }

  Future<bool> getStatuses() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.location].request();

    if (await Permission.location.isGranted) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  void startLocationService() {
    BackgroundLocator.registerLocationUpdate(LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        initDataCallback: {},
        disposeCallback: LocationCallbackHandler.disposeCallback,
        autoStop: false,
        iosSettings: const IOSSettings(
            accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 0),
        androidSettings: const AndroidSettings(
          accuracy: LocationAccuracy.NAVIGATION,
          interval: 5,
          distanceFilter: 0,
        ));

    print('start');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE8D8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage("assets/images/splash.png"),
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> runner() async {
    // shared pref. 초기화/로드
    await PreferenceManager.instance.init();

    IsolateNameServer.registerPortWithName(
        port.sendPort, LocationServiceRepository.isolateName);
    port.listen((dynamic data) {
      print('datadatadatadatadatadatadatadatadatadatadata');
    });

    bool isLocationGranted = false;

    while (!isLocationGranted) {
      isLocationGranted = await getStatuses();
      if (!isLocationGranted) {
        makeToast(msg: "앱을 사용하기 위해 위치 권한을 활성화해주세요");
      }
      await Future.delayed(const Duration(milliseconds: 2000));
    }

    await checkLocationOn();
    await initPlatformState();
    startLocationService();

    PersonalInfo personalInfo =
        Provider.of<PersonalInfo>(context, listen: false);

    // await Future.delayed(const Duration(milliseconds: 3000));
    if (personalInfo.isFirst) {
      await Navigator.pushReplacementNamed(context, "/alarm");
    } else {
      await Navigator.pushReplacementNamed(context, "/home");
    }
  }
}
