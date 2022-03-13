import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/background_locator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app/util/location_service_repository.dart';
import 'package:app/util/location_callback_handler.dart';
import 'package:background_locator/location_dto.dart';
import 'package:location/location.dart' as location;
import 'package:app/util/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:app/util/utils.dart';
import 'dart:isolate';
import 'dart:ui';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  ReceivePort port = ReceivePort();
  late bool isBackgroudServiceRunning;
  late LocationDto lastLocation;

  @override
  void initState() {
    runner();
    super.initState();
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
    // 위치 권한
    bool isLocationGranted = false;
    while (!isLocationGranted) {
      isLocationGranted = await getStatuses();
      if (!isLocationGranted) {
        makeToast(msg: "앱을 사용하기 위해 위치 권한을 활성화해주세요");
      }
      await Future.delayed(const Duration(milliseconds: 2000));
    }

    await checkLocationOn();

    // shared pref. 초기화/로드
    try {
      await PreferenceManager.instance.init();
    } catch (err) {
      makeToast(msg: "알람 정보가 손상되어 초기화합니다");
      await PreferenceManager.instance.deleteAllAlarm();
    }
    if (IsolateNameServer.lookupPortByName(
            LocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          LocationServiceRepository.isolateName);
    }

    IsolateNameServer.registerPortWithName(
        port.sendPort, LocationServiceRepository.isolateName);

    port.listen(
      (dynamic data) async {},
    );

    await initPlatformState();
    await _startLocator();

    if (PreferenceManager.instance.readAlarm().isEmpty) {
      await Navigator.pushReplacementNamed(context, "/alarm");
    } else {
      await Navigator.pushReplacementNamed(context, "/home");
    }
  }

  Future<void> initPlatformState() async {
    await BackgroundLocator.initialize();
    final _isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isBackgroudServiceRunning = _isRunning;
    });
  }

  Future<void> _startLocator() async {
    Map<String, dynamic> data = {'countInit': 1};
    return await BackgroundLocator.registerLocationUpdate(
      LocationCallbackHandler.callback,
      initCallback: LocationCallbackHandler.initCallback,
      initDataCallback: data,
      disposeCallback: LocationCallbackHandler.disposeCallback,
      iosSettings: const IOSSettings(
          accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 0),
      autoStop: false,
      androidSettings: const AndroidSettings(
        accuracy: LocationAccuracy.NAVIGATION,
        interval: 5,
        distanceFilter: 0,
        client: LocationClient.google,
        // androidNotificationSettings: AndroidNotificationSettings(
        //   notificationChannelName: 'Location tracking',
        //   notificationTitle: 'Start Location Tracking',
        //   notificationMsg: 'Track location in background',
        //   notificationBigMsg:
        //       'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
        //   notificationIconColor: Colors.grey,
        //   notificationTapCallback: LocationCallbackHandler.notificationCallback,
        // ),
      ),
    );
  }
}
