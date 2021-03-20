import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kelly_proto/pushCall.dart' as pushCall;
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(Kelly());
}

class Kelly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterTts flutterTts = FlutterTts();
  String alarmTitle = 'Title';
  String alarmContents = 'contents';
  String settedTime = '07:00';
  String timeOfNow = TimeOfDay.now().toString()[10] +
      TimeOfDay.now().toString()[11] +
      TimeOfDay.now().toString()[12] +
      TimeOfDay.now().toString()[13] +
      TimeOfDay.now().toString()[14];
  dynamic myToken = ' ';

  void setAlarm() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Column(
            children: <Widget>[
              Text('알람 설정'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: '제목을 입력하세요'),
                onChanged: (String value) {
                  alarmTitle = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: '내용을 입력하세요'),
                onChanged: (String value) {
                  alarmContents = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('저장'),
              onPressed: () {
                setState(() {
                  alarmTitle = alarmTitle;
                  alarmContents = alarmContents;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showMyInfo() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Column(
            children: <Widget>[
              Text('내 정보'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('현재 내 토큰 : $myToken'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
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
  void initState() {
    super.initState();
    printMyToken();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              title: Column(
                children: <Widget>[
                  Text('알림'),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('$alarmContents'),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
        flutterTts.speak(alarmContents);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        flutterTts.speak(alarmContents);
        // ttsSpeak();
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        flutterTts.speak(alarmContents);
        // ttsSpeak();
      },
    );
  }

  void printMyToken() async {
    myToken = await _firebaseMessaging.getToken();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kelly',
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 400,
                  child: Text(
                    '\n사용자 이름',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.end,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('   Today',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500)),
                    SizedBox(width: 190),
                    TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child:
                          Text('모두 보기', style: TextStyle(color: Colors.black)),
                    ),
                    TextButton(
                      onPressed: () {
                        showMyInfo();
                        setState(() {});
                      },
                      child: Text('설정', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          blurRadius: 4.0,
                          spreadRadius: 2.0)
                    ],
                  ),
                  width: 380,
                  child: ListTile(
                    leading: Icon(Icons.access_alarm, color: Colors.black),
                    title: Text(
                      '$alarmTitle',
                      style: TextStyle(fontSize: 30),
                    ),
                    subtitle: Text('$settedTime | $alarmContents'),
                    trailing: IconButton(
                      icon: Icon(Icons.mode_edit),
                      onPressed: () {
                        setAlarm();
                        setState(() {});
                      },
                    ),
                  ),
                ),
                Row(children: [
                  TextButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text('저장', style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                      flutterTts.speak(alarmContents);
                    },
                    child: Text('재생', style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                      pushCall.pushNoti();
                    },
                    child: Text('푸시', style: TextStyle(color: Colors.black)),
                  ),
                  Text(timeOfNow),
                ]),
                Container(
                  width: 380,
                  child: ElevatedButton(
                    onPressed: () {
                      Future<TimeOfDay> selectedTime = showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      selectedTime.then((timeOfDay) {
                        setState(() {
                          settedTime = '${timeOfDay.hour}:${timeOfDay.minute}';
                        });
                      });
                      setState(() {});
                    },
                    child: Icon(Icons.alarm_add, color: Colors.grey),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
