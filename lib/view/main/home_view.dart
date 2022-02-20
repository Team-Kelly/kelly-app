import 'package:app/view/alarm/select_path_view.dart';
import 'package:cotten_candy_ui/cotten_candy_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCE8D8),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),

            ///
            /// 상단 노티바
            ///
            Container(
              height: 50,
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  // TODO: 추후 필요한 경우, styled text 패키지 추가
                  // https://pub.dev/packages/styled_text
                  children: [
                    Text(
                      "오전 ",
                      style: TextStyle(color: Colors.yellow),
                    ),
                    Text(
                      "출근길 빗길 조심하세요!",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),

            ///
            /// 상단 안내문구
            ///
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "아무개님🥰",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "날씨가 맑네요. 하지만 오후에 비 예보가 있습니다!",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset("assets/dog.png"),
                ),
              ],
            ),

            ///
            /// 날씨 이모티콘
            ///
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Stack(
                      children: const [
                        Text("현위치: 서초구"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 200,
              height: 200,
              child: Image.asset("assets/weather/sunny.png"),
            ),

            ///
            /// 하단 날씨위젯
            ///
            SizedBox(height: 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  weatherTile(
                      title: '현재',
                      color: const Color(0xFFFFAE9A),
                      imagePath: 'assets/weather/mostly_sunny.png',
                      temper: '온도'),
                  weatherTile(
                      title: '+1시간',
                      color: const Color(0xFFFFAE9A),
                      imagePath: 'assets/weather/partly_cloudy.png',
                      temper: '온도'),
                  weatherTile(
                      title: '+2시간',
                      color: const Color(0xFFFFAE9A),
                      imagePath: 'assets/weather/cloudy.png',
                      temper: '온도'),
                  weatherTile(
                      title: '+3시간',
                      color: const Color(0xFFFFAE9A),
                      imagePath: 'assets/weather/rainy.png',
                      temper: '온도'),
                  weatherTile(
                      title: '+4시간',
                      color: const Color(0xFFFFAE9A),
                      imagePath: 'assets/weather/stormy.png',
                      temper: '온도'),
                  weatherTile(
                      title: '+5시간',
                      color: const Color(0xFFFFAE9A),
                      imagePath: 'assets/weather/snowy.png',
                      temper: '온도'),
                ],
              ),
              height: 100,
            ),
            SizedBox(height: 10),

            ///
            /// MY 리스트
            ///
            Text(
              "MY 리스트\n",
              // style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: SizedBox(
                height: 450,
                // color: Colors.blue,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
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
                                child: Image.asset(
                                    'assets/transport/bus-normal.png'),
                              ),
                              Text('버스 > '),
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: Image.asset(
                                    'assets/transport/gyeongchun.png'),
                              ),
                              Text('지하철 > '),
                              SizedBox(
                                width: 15,
                                height: 15,
                                child:
                                    Image.asset('assets/transport/1-line.png'),
                              ),
                              Text('지하철'),
                            ],
                          )),
                      routeInfo(
                          title: Text('소요시간'),
                          subtitle: Row(
                            children: [
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: Image.asset(
                                    'assets/transport/bus-town.png'),
                              ),
                              Text('버스 > '),
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: Image.asset('assets/transport/walk.png'),
                              ),
                              Text('도보 > '),
                              SizedBox(
                                width: 15,
                                height: 15,
                                child:
                                    Image.asset('assets/transport/2-line.png'),
                              ),
                              Text('지하철')
                            ],
                          )),
                      routeInfo(
                          title: Text('소요시간'),
                          subtitle: Row(
                            children: [
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: Image.asset(
                                    'assets/transport/bus-metro.png'),
                              ),
                              Text('버스 > '),
                              SizedBox(
                                width: 15,
                                height: 15,
                                child:
                                    Image.asset('assets/transport/3-line.png'),
                              ),
                              Text('지하철')
                            ],
                          )),
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
                                child: Image.asset(
                                    'assets/transport/bus-trunk.png'),
                              ),
                              Text('버스 > '),
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: Image.asset(
                                    'assets/transport/gyeongchun.png'),
                              ),
                              Text('지하철')
                            ],
                          )),
                      routeInfo(
                          title: Text('소요시간'),
                          subtitle: Row(
                            children: [
                              SizedBox(
                                width: 15,
                                height: 15,
                                child:
                                    Image.asset('assets/transport/jungang.png'),
                              ),
                              Text('지하철 > '),
                              SizedBox(
                                width: 15,
                                height: 15,
                                child: Image.asset(
                                    'assets/transport/bus-airport.png'),
                              ),
                              Text('버스'),
                            ],
                          )),
                      routeInfo(
                          title: Text('소요시간'),
                          subtitle: Row(
                            children: [
                              SizedBox(
                                width: 15,
                                height: 15,
                                child:
                                    Image.asset('assets/transport/6-line.png'),
                              ),
                              Text('지하철 > '),
                              SizedBox(
                                width: 15,
                                height: 15,
                                child:
                                    Image.asset('assets/transport/bus-etc.png'),
                              ),
                              Text('버스'),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget weatherTile(
        {required String title,
        required Color color,
        required String temper,
        required String imagePath}) =>
    Container(
      width: 55,
      height: 80,
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          Container(
            width: 30,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
            child: Image.asset(imagePath),
          ),
          Text(temper),
        ],
      ),
    );