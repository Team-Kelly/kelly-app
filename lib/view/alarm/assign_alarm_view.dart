import 'package:app/view/alarm/select_destination_view.dart';
import 'package:flutter/material.dart';
import 'package:cotten_candy_ui/cotten_candy_ui.dart';

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
              children: const [
                Text('아침부터 비를 맞았네...', style: TextStyle(fontSize: 30)),
                Text('어제는 날씨 좋았잖아...', style: TextStyle(fontSize: 30)),
                Text('시작이 반인데...!\n', style: TextStyle(fontSize: 30)),
              ],
            ),
            CandyButton(
              child: const Text('나의 시작길 입력하기',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectDestionationView(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
