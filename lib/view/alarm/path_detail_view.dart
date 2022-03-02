import 'package:app/view/alarm/time_setting_view.dart';
import 'package:cotton_candy_ui/cotton_candy_ui.dart';
import 'package:flutter/material.dart';
import 'select_path_view.dart';

class PathDetailView extends StatefulWidget {
  const PathDetailView({Key? key}) : super(key: key);

  @override
  _PathDetailViewState createState() => _PathDetailViewState();
}

class _PathDetailViewState extends State<PathDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFFFFFF),
        title: Text(
          '집  >  광운대학교',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          routeInfo(
              title: Text(
                '소요시간',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              subtitle: Row(
                children: [
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: Image.asset('assets/icons/transport/walk.png'),
                  ),
                  Text('도보 > '),
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: Image.asset('assets/icons/transport/bus-normal.png'),
                  ),
                  Text('버스 > '),
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: Image.asset(
                        'assets/icons/transport/subway-gyeongchun.png'),
                  ),
                  Text('지하철 > '),
                  SizedBox(
                    width: 15,
                    height: 15,
                    child:
                        Image.asset('assets/icons/transport/subway-1-line.png'),
                  ),
                  Text('지하철'),
                ],
              )),
          Container(
            width: MediaQuery.of(context).size.width - 60,
            height: 3,
            color: const Color(0xFFF2F2F2),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: CandyTimeLine(
                children: [
                  CandyIndicator(
                    child: Text(
                      '출발',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    title: Text('집'),
                  ),
                  CandyIndicator(
                    child: Icon(
                      Icons.directions_run,
                      color: Colors.white,
                    ),
                    title: Text('도보 20분'),
                    subTitle: Text('12km'),
                  ),
                  CandyIndicator(
                    child: Icon(
                      Icons.directions_bus,
                      color: Colors.white,
                    ),
                    title: Text('마석역'),
                    subTitle: Text('경춘선'),
                  ),
                  CandyIndicator(
                    child: Text(
                      '도착',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    title: Text('광운대역'),
                    subTitle: Text('1호선'),
                  ),
                ],
                connector: CandyConnector(
                  height: 80,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          CandyButton(
            width: 346,
            child: const Text(
              '경로 추가',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TimeSettingView(),
              ),
            ),
          )
        ],
      )),
    );
  }
}
