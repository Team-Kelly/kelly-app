import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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
      });
    });
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
          child: Column(
            children: [
              TextButton(
                child: Text("Local Notifications Show!"),
                onPressed: () async => await noti.show(),
              ),
              ElevatedButton(
                onPressed: () {
                  setTime();
                },
                child:
                    Text("Select time", style: TextStyle(color: Colors.black)),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              Text("$timeSet"),
              ElevatedButton(
                onPressed: () async {
                  String appToken = await FirebaseMessaging.instance.getToken();
                  updateAlarm(timeSet, appToken);
                },
                child: Text("Send FCM", style: TextStyle(color: Colors.black)),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
}
