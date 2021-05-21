import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'noti.dart' as appNoti;

void main() => runApp(MaterialApp(
      home: Kelly(),
    ));

class Kelly extends StatefulWidget {
  @override
  _KellyState createState() => _KellyState();
}

class _KellyState extends State<Kelly> {
  appNoti.Noti noti = appNoti.AppNoti();

  List infoList = ['날씨 정보', '버스 정보', '지하철 정보', '주식 시세 정보', '암호화폐 시세 정보'];
  //dropdown메뉴의 요소들 선언 및 초기화
  int notiID = 1;
  String selectedInfo = '날씨 정보';
  String location = '서울';
  //날시정보 호출에 필요한 parameter 선언 및 초기화
  String routeID = '100100148';
  String busStationID = '11283';
  String direction = '월계동';
  //버스정보 호출에 필요한 parameter 선언 및 초기화
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
  @override
  void initState() {
    Future(noti.init);
    //notification에 대한 권한요청과 초기설정
    super.initState();
  }

  void setTime() {
    Future<TimeOfDay> selectedTime =
        showTimePicker(context: context, initialTime: TimeOfDay.now());
    selectedTime.then((timeOfDay) {
      setState(() {
        timeSet = '${timeOfDay.hour}:${timeOfDay.minute}';
        hourSet = timeOfDay.hour;
        minuteSet = timeOfDay.minute;
      });
    });
  } //timepicker로 시간 설정

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

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(
          "Kelly",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
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
                        selectedInfo = value;
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
                    child: Text("Select time",
                        style: TextStyle(color: Colors.black)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white))),
              ])),
        ],
      ));
}
