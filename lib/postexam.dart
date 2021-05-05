import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Alarm> createAlarm(String timer) async {
  final http.Response response = await http.post(
    Uri.parse('http://222.112.225.80:8081/test'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      "timer": timer,
      "appToken":"????????????"
    }), //jsonEncode로 서버에 추가할 json파일 생성 후 post
  );

  if (response.statusCode == 200) {
    return Alarm.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create alarm.${response.statusCode}');
  }
}

class Alarm {
  final String timer;
  final String appToken;

  Alarm({this.timer, this.appToken});

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      timer: json['timer'],
      appToken: json['appToken'],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  Future<Alarm> _futureAlarm;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlarm == null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: 'Enter Title'),
                    ),
                    ElevatedButton(
                      child: Text('Create Data'),
                      onPressed: () {
                        setState(() {
                          _futureAlarm = createAlarm(_controller.text);
                        });
                      },
                    ),
                  ],
                )
              : FutureBuilder<Alarm>(
                  future: _futureAlarm,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.timer);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return CircularProgressIndicator();
                  },
                ),
        ),
      ),
    );
  }
}
