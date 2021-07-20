import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'permission.dart';
import 'noti.dart' as appNoti;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:app_settings/app_settings.dart';

void main() {
  runApp(MaterialApp(
    home: Kelly(),
  ));
}

class Kelly extends StatefulWidget {
  @override
  _KellyState createState() => _KellyState();
}

class _KellyState extends State<Kelly> {
  appNoti.Noti noti = appNoti.AppNoti();
  FlutterTts tts = FlutterTts();

  List infoList = [
    '날씨 정보',
    '버스 정보',
    '지하철 정보',
    // '주식 시세 정보',
    // '암호화폐 시세 정보',
    '음성메시지'
  ];
  //dropdown메뉴의 요소들 선언 및 초기화
  int notiID = 1;
  String selectedInfo = '날씨 정보';
  //알람 기본정보에 관한 parameter 선언 및 초기화
  String location = '서울';
  //날시정보 호출에 필요한 parameter 선언 및 초기화
  String routeID = '100100148';
  String busStationID = '11283';
  String direction = '월계동';
  String ttsTitle = 'title1';
  //버스정보 호출에 필요한 parameter 선언 및 초기화
  String ttsText = '';
  int hourSet = int.parse(
      TimeOfDay.now().toString()[10] + TimeOfDay.now().toString()[11]);
  int minuteSet = int.parse(
      TimeOfDay.now().toString()[13] + TimeOfDay.now().toString()[14]);
  //알람 호출에 공통으로 필요한 시각, 분 정보 선언 및 초기화
  String timeSet = TimeOfDay.now().toString()[10] +
      TimeOfDay.now().toString()[11] +
      TimeOfDay.now().toString()[12] +
      TimeOfDay.now().toString()[13] +
      TimeOfDay.now().toString()[14];
  //timepicker에서의 시간 호출에 필요한 parameter 선언 및 초기화
  late DateTime cupertinoTime = DateTime.now();

  @override
  void initState() {
    requestPermission();
    noti.init();
    soundSet();
    //notification에 대한 권한요청과 초기설정
    super.initState();
  }

  void soundSet() async {
    Directory? exDir = await getExternalStorageDirectory();
    print("${exDir!.path}");
  }

  void setTime() {
    Future<TimeOfDay?> selectedTime =
        showTimePicker(context: context, initialTime: TimeOfDay.now());
    selectedTime.then((timeOfDay) {
      setState(() {
        timeSet = '${timeOfDay!.hour}:${timeOfDay.minute}';
        hourSet = timeOfDay.hour;
        minuteSet = timeOfDay.minute;
      });
    });
  } //timepicker로 시간 설정

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

  void toastMessage() {
    Fluttertoast.showToast(
        msg: "알람이 설정되었습니다.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[600],
        fontSize: 10,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT);
  } //notification을 요청하는 버튼 onPressed일 때 메시지 출력

  void setWeatherInfo() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Column(
            children: <Widget>[
              Text('날씨 정보 설정'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: '지역명을 입력하세요'),
                onChanged: (value) {
                  setState(() {
                    location = value;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('저장'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void setBusInfo() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Column(
            children: <Widget>[
              Text('버스 정보 설정'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: '노선번호를 입력하세요'),
                onChanged: (value) {
                  setState(() {
                    routeID = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: '정류장번호를 입력하세요'),
                onChanged: (value) {
                  setState(() {
                    busStationID = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: '정류장 방향을 입력하세요'),
                onChanged: (value) {
                  setState(() {
                    direction = value;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('저장'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void setTextInfo() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Column(
            children: <Widget>[
              Text('음성메시지 설정'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: '음성파일 제목을 입력하세요'),
                onChanged: (value) {
                  setState(() {
                    ttsTitle = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: '음성메시지를 입력하세요'),
                onChanged: (value) {
                  setState(() {
                    ttsText = value;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('저장'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          "Kelly",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.orangeAccent),
                currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.orangeAccent,
                    foregroundImage: AssetImage('assets/kelly.png')),
                accountName: Text(
                  'name',
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: Text(
                  'kelly@kelly.com',
                  style: TextStyle(color: Colors.black),
                )),
            ListTile(
              leading: Icon(Icons.perm_identity),
              title: Text("계정 관리"),
              subtitle: Text("계정 설정으로 이동합니다."),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("권한 설정"),
              subtitle: Text("앱 권한 설정으로 이동합니다."),
              onTap: () async {
                await AppSettings.openAppSettings();
              },
            ), //애플리케이션 설정 페이지로 이동하는 tile
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text("API 마켓"),
              subtitle: Text("API 마켓으로 이동합니다."),
              onTap: () {},
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.black,
      //   items: [
      //     BottomNavigationBarItem(label: 'HOME', icon: Icon(Icons.home)),
      //     BottomNavigationBarItem(label: 'ADD', icon: Icon(Icons.add_alarm))
      //   ],
      // ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Container(
                    height: 70,
                    width: 240,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Card(
                        elevation: 2,
                        child: Text(
                          '\n$selectedInfo | $timeSet',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ))), // 현재 설정된 알람의 정보를 card에 표시
                Container(
                  height: 50,
                  width: 160,
                  child: DropdownButton(
                    hint: Text('알람 정보를 선택하세요'),
                    value: selectedInfo,
                    items: infoList.map((value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedInfo = value.toString();
                      });
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (selectedInfo == '날씨 정보') {
                        setWeatherInfo();
                      } else if (selectedInfo == '버스 정보') {
                        setBusInfo();
                      } else if (selectedInfo == '음성메시지') {
                        setTextInfo();
                      }
                    },
                    child: Text("Set infomation",
                        style: TextStyle(color: Colors.black)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white))),

                ElevatedButton(
                    onPressed: () async {
                      if (selectedInfo == '날씨 정보') {
                        await noti.weatherAlert(
                            notiID, hourSet, minuteSet, selectedInfo, location);
                      } else if (selectedInfo == '버스 정보') {
                        await noti.busAlert(notiID, hourSet, minuteSet,
                            selectedInfo, routeID, busStationID, direction);
                      } else if (selectedInfo == '음성메시지') {
                        //AudioServiceBackground.run(()=>TextPlayerTask());
                        //await noti.ttsAlert(notiID, hourSet, minuteSet, ttsTitle, ttsText);
                        await tts.synthesizeToFile('$ttsText', '$ttsTitle.mp3');
                      }
                      toastMessage();
                      notiID++;
                    },
                    child: Text("Local Notification",
                        style: TextStyle(color: Colors.black)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white))),

                ElevatedButton(
                    onPressed: () {
                      setTime();
                    },
                    child: Text("Select Android time",
                        style: TextStyle(color: Colors.black)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white))),
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
              ])),
        ],
      ));
}
