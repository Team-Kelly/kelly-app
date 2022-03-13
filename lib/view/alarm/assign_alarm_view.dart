import 'dart:isolate';
import 'dart:ui';

import 'package:app/util/location_callback_handler.dart';
import 'package:app/util/location_service_repository.dart';
import 'package:app/view/alarm/select_destination_view.dart';
import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:cotton_candy_ui/cotton_candy_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AssignAlarmView extends StatefulWidget {
  const AssignAlarmView({
    Key? key,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final Color backgroundColor;

  @override
  _AssignAlarmViewState createState() => _AssignAlarmViewState();
}

class _AssignAlarmViewState extends State<AssignAlarmView> {
  FlutterTts tts = FlutterTts();
  ReceivePort port = ReceivePort();

  late bool isRunning;
  late LocationDto lastLocation;
  @override
  void initState(){
    super.initState();
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
    initPlatformState();
  }

   Future<void> initPlatformState() async {
    // await BackgroundLocator.initialize();
    final _isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = _isRunning;
    });
  }

   Future<void> _startLocator() async{
    Map<String, dynamic> data = {'countInit': 1};
    return await BackgroundLocator.registerLocationUpdate(LocationCallbackHandler.callback,
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
            //     notificationChannelName: 'Location tracking',
            //     notificationTitle: 'Start Location Tracking',
            //     notificationMsg: 'Track location in background',
            //     notificationBigMsg:
            //         'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
            //     notificationIconColor: Colors.grey,
            //     notificationTapCallback:
            //         LocationCallbackHandler.notificationCallback)
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '시작이 반이다',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 2 / 39,
                      height: 1.5,
                      fontWeight: FontWeight.w800,
                      color: CandyColors.candyPink),
                ),
                Text(
                  '아침부터 비를 맞았네...',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 13,
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '어제는 날씨 좋았잖아...',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 13,
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '시작이 반인데...!\n',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 13,
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            CandyButton(
              child: const Text('나의 시작길 입력하기',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  )),
              onPressed: () async{
                await _startLocator();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectDestionationView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
