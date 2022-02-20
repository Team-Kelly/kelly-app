import 'package:cotten_candy_ui/cotten_candy_ui.dart';
import 'package:app/view/main/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeSettingView extends StatefulWidget {
  const TimeSettingView({Key? key}) : super(key: key);

  @override
  _TimeSettingViewState createState() => _TimeSettingViewState();
}

class _TimeSettingViewState extends State<TimeSettingView> {
  bool isEveryDay = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {/*Navigator.pop(context);*/},
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          title: Text('알람 설정'),
          actions: [
            TextButton(
                onPressed: () {},
                child: TextButton(
                    onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                        ),
                    child: Text('저장')))
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              color: const Color(0xFFF5F5F5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                          text: '오전 ',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFFFBB3C))),
                      TextSpan(
                          text: '출근길 빗길 조심하세요!',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, color: Colors.black))
                    ]),
                  )
                ],
              ),
            ),
            CandyTimePicker(
              onChanged: (hour, minute) {},
              highlightColor: const Color(0xFFFFBB3C),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '날짜',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.black),
                ),
                CupertinoSwitch(
                    activeColor: const Color(0xFFFFBB3C),
                    value: isEveryDay,
                    onChanged: (value) {
                      setState(() {
                        isEveryDay = value;
                      });
                    })
              ],
            ),
            CandyDayOfTheWeek(
              onChanged: (value) {},
              selectedColor: const Color(0xFFFFBB3C),
            )
          ],
        ));
  }
}
