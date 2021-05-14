import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'noti.dart' as appNoti;
import 'calling.dart';

void main() => runApp(MaterialApp(
      home: Kelly(),
    ));

class Kelly extends StatefulWidget {
  @override
  _KellyState createState() => _KellyState();
}

class _KellyState extends State<Kelly> {
  appNoti.Noti noti = appNoti.AppNoti();
  String appToken = ' ';
  int hourSet = int.parse(
      TimeOfDay.now().toString()[10] + TimeOfDay.now().toString()[11]);
  int minuteSet = int.parse(
      TimeOfDay.now().toString()[13] + TimeOfDay.now().toString()[14]);
  String timeSet = TimeOfDay.now().toString()[10] +
      TimeOfDay.now().toString()[11] +
      TimeOfDay.now().toString()[12] +
      TimeOfDay.now().toString()[13] +
      TimeOfDay.now().toString()[14];
  @override
  void initState() {
    Future(noti.init);
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
  }

  void toastMessage() {
    Fluttertoast.showToast(
        msg: "알람이 설정되었습니다.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[600],
        fontSize: 10,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT);
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
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("$timeSet"),
          ElevatedButton(
              onPressed: () async {
                await noti.alert(hourSet, minuteSet);
                toastMessage();
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
              child: Text("Select time", style: TextStyle(color: Colors.black)),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white))),
          ElevatedButton(
              onPressed: () async {
                String appToken = await FirebaseMessaging.instance.getToken();
                createAlarm(timeSet, appToken);
                toastMessage();
              },
              child: Text("save alarm", style: TextStyle(color: Colors.black)),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white))),
        ])),
      );
}
