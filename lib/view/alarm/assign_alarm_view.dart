import 'package:app/view/alarm/select_destination_view.dart';
import 'package:cotton_candy_ui/cotton_candy_ui.dart';
import 'package:flutter/material.dart';

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
