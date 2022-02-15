import 'package:app/view/main/home_view.dart';
import 'package:cotten_candy_ui/cotten_candy_ui.dart';
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
          onPressed: () {/*Navigator.pop(context);*/},
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          routeInfo(
              title: Text('소요시간'),
              subtitle: Row(
                children: [
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: Image.asset('assets/transport/walk.png'),
                  ),
                  Text('도보 > '),
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: Image.asset('assets/transport/bus-normal.png'),
                  ),
                  Text('버스 > '),
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: Image.asset('assets/transport/gyeongchun.png'),
                  ),
                  Text('지하철 > '),
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: Image.asset('assets/transport/1-line.png'),
                  ),
                  Text('지하철'),
                ],
              )),
          Container(
            width: 346,
            height: 3,
            color: const Color(0xFFF2F2F2),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: 100,
              child: const CandyTimeLine(
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
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
            ),
          )
        ],
      )),
    );
  }
}
