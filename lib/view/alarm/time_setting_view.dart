import 'package:app/view/alarm/path_detail_view.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PathDetailView(),
            ),
          ),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        title: Text('알람 설정', style: TextStyle(color: Colors.black)),
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
              child: Text(
                '저장',
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.fromLTRB(0, 40, 0, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '  간편하게 나의 시작 시간을 등록해보세요',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '주중 아침 7시마다 알람',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        style:
                            ButtonStyle(splashFactory: NoSplash.splashFactory),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '주중 낯 12시마다 알람',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        style:
                            ButtonStyle(splashFactory: NoSplash.splashFactory),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '주중 오후 3시마다 알람',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        style:
                            ButtonStyle(splashFactory: NoSplash.splashFactory),
                      )
                    ],
                  ),
                ),
                CandyTimePicker(
                  width: 346,
                  onChanged: (hour, minute) {},
                  highlightColor: const Color(0xFFFFBB3C),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      '날짜',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: SizedBox(),
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
                  borderWidth: 1.2,
                  selectedColor: const Color(0xFFFFBB3C),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
