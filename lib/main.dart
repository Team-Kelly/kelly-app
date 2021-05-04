import 'package:flutter/material.dart';
import 'noti.dart' as appNoti;
import 'noti.dart';

void main() => runApp(MaterialApp(home: Kelly(), ));

class Kelly extends StatefulWidget {
  @override
  _KellyState createState() => _KellyState();
}

class _KellyState extends State<Kelly> {

  Noti noti = appNoti.AppNoti();

  @override
  void initState() {
    Future(noti.init);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: TextButton(
        child: Text("Local Notifications Show!"),
        onPressed: () async => await noti.show(),
      ),
    ),
  );
}