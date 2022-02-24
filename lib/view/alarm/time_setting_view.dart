import 'package:app/view/alarm/path_detail_view.dart';
import 'package:cotton_candy_ui/cotton_candy_ui.dart';
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
  late FixedExtentScrollController hourScrollController;
  late FixedExtentScrollController minuteScrollController;
  late FixedExtentScrollController ampmScrollController;
  @override
  void initState() {
    hourScrollController = FixedExtentScrollController(
        initialItem: (TimeOfDay.now().hour > 11)
            ? TimeOfDay.now().hour - 12
            : TimeOfDay.now().hour);
    minuteScrollController =
        FixedExtentScrollController(initialItem: TimeOfDay.now().minute);
    ampmScrollController = FixedExtentScrollController(
        initialItem: (TimeOfDay.now().hour > 11) ? 1 : 0);
    super.initState();
  }

  void timeSet(int ampm, int hour, int minute) {
    ampmScrollController.animateToItem(ampm,
        duration: const Duration(milliseconds: 400), curve: Curves.ease);
    hourScrollController.animateToItem(hour,
        duration: const Duration(milliseconds: 400), curve: Curves.ease);
    minuteScrollController.animateToItem(minute,
        duration: const Duration(milliseconds: 400), curve: Curves.ease);
  }

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
        title: const Text('알람 설정', style: TextStyle(color: Colors.black)),
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
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  margin: const EdgeInsets.fromLTRB(0, 40, 0, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '  간편하게 나의 시작 시간을 등록해보세요',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      TextButton(
                        onPressed: () {
                          timeSet(0, 7, 60);
                        },
                        child: const Text(
                          '주중 아침 7시마다 알람',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory),
                      ),
                      TextButton(
                        onPressed: () {
                          timeSet(1, 12, 60);
                        },
                        child: const Text(
                          '주중 낯 12시마다 알람',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory),
                      ),
                      TextButton(
                        onPressed: () {
                          timeSet(1, 3, 60);
                        },
                        child: const Text(
                          '주중 오후 3시마다 알람',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory),
                      )
                    ],
                  ),
                ),
                CandyTimePicker(
                  hourScrollController: hourScrollController,
                  minuteScrollController: minuteScrollController,
                  ampmScrollController: ampmScrollController,
                  width: 346,
                  onChanged: (hour, minute) {},
                  highlightColor: const Color(0xFFFFBB3C),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    timeSetButton(
                        child: const Text('2시'),
                        onPressed: () {
                          timeSet(0, 2, 60);
                        },
                        color: const Color(0xFFF4F4F4),
                        width: 50,
                        height: 25),
                    timeSetButton(
                        child: const Text('4시'),
                        onPressed: () {
                          timeSet(0, 4, 60);
                        },
                        color: const Color(0xFFF4F4F4),
                        width: 50,
                        height: 25),
                    timeSetButton(
                        child: const Text('6시'),
                        onPressed: () {
                          timeSet(0, 6, 60);
                        },
                        color: const Color(0xFFF4F4F4),
                        width: 50,
                        height: 25),
                    timeSetButton(
                        child: const Text('8시'),
                        onPressed: () {
                          timeSet(0, 8, 60);
                        },
                        color: const Color(0xFFF4F4F4),
                        width: 50,
                        height: 25),
                    timeSetButton(
                        child: const Text('10시'),
                        onPressed: () {
                          timeSet(0, 10, 60);
                        },
                        color: const Color(0xFFF4F4F4),
                        width: 50,
                        height: 25),
                    timeSetButton(
                        child: const Text('12시'),
                        onPressed: () {
                          timeSet(1, 0, 60);
                        },
                        color: const Color(0xFFF4F4F4),
                        width: 50,
                        height: 25),
                  ],
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

Widget timeSetButton(
        {required Widget child,
        required void Function()? onPressed,
        required Color color,
        required double width,
        required double height}) =>
    Container(
        margin: EdgeInsets.fromLTRB(4, 10, 4, 10),
        child: CandyButton(
          borderRadius: 5,
          width: width,
          height: height,
          buttonColor: color,
          child: child,
          onPressed: onPressed,
        ));
