import 'dart:async';
import 'noti.dart' as appNoti;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'permission.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  appNoti.Noti noti = appNoti.AppNoti();
  int notiID = 1;
  String selectedInfo = '날씨 정보';
  //알람 기본정보에 관한 parameter 선언 및 초기화
  String location = '서울';
  int hourSet = int.parse(
      TimeOfDay.now().toString()[10] + TimeOfDay.now().toString()[11]);
  int minuteSet = int.parse(
      TimeOfDay.now().toString()[13] + TimeOfDay.now().toString()[14]);
  String timeSet = TimeOfDay.now().toString()[10] +
      TimeOfDay.now().toString()[11] +
      TimeOfDay.now().toString()[12] +
      TimeOfDay.now().toString()[13] +
      TimeOfDay.now().toString()[14];
  late DateTime now = DateTime.now();
  late DateTime cupertinoTime = DateTime.now();

  @override
  void initState() {
    requestPermission();
    noti.init();
    Timer.periodic(Duration(milliseconds: 100), (_) {
      setState(() {
        now = DateTime.now(); // or BinaryTime see next step
      });
    });
    //notification에 대한 권한요청과 초기설정
    super.initState();
  }

  void cupertinoSet(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            cupertinoTime = val;
                            timeSet = '${val.hour}:${val.minute}';
                            hourSet = val.hour;
                            minuteSet = val.minute;
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  void alart() async {
    Timer.periodic(Duration(seconds: 1), (_) async {
      if (cupertinoTime.minute == now.minute &&
          cupertinoTime.hour == now.hour &&
          cupertinoTime.second == now.second) {
        await noti.weather(notiID, selectedInfo, location);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('timer'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$now'),
              Text('$cupertinoTime'),
              ElevatedButton(
                  onPressed: () {
                    cupertinoSet(context);
                  },
                  child: Text("Select Cupertino time",
                      style: TextStyle(color: Colors.black)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white))),
              ElevatedButton(
                  onPressed: () async {
                    alart();
                    notiID++;
                  },
                  child: Text("Local Notification",
                      style: TextStyle(color: Colors.black)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white))),
              ElevatedButton(
                  onPressed: () async {
                    await noti.weather(notiID, selectedInfo, location);
                    notiID++;
                  },
                  child: Text("Just Notification",
                      style: TextStyle(color: Colors.black)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white))),
            ],
          ),
        ));
  }
}
