import 'package:app/util/preference_manager.dart';
import 'package:app/view/alarm/select_destination_view.dart';
import 'package:app/view/alarm/select_path_view.dart';
import 'package:cotton_candy_ui/cotton_candy_ui.dart';
import 'package:app/util/weather.vo.dart';
import 'package:app/util/weather.dto.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late WeatherVO weather;
  bool isLoading = false;
  PreferenceManager prefs = PreferenceManager.instance;

  Future<void> getlist() async {
    //
    //////////////////////////////////////////////////////////////////////////////////////
    // 알람 정보 읽어오는 곳
    List<Alarm> alarms = prefs.readAlarm();

    isLoading = false;
    weather =
        await WeatherDTO.get(latitude: 37.6576769, longitude: 127.3007637);
    isLoading = true;
    setState(() {
      weather = weather;
    });
  }

  @override
  void initState() {
    getlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE8D8),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///
            /// 상단 노티바
            ///
            // Container(
            //   height: 50,
            //   color: Colors.white,
            //   child: Padding(
            //     padding: const EdgeInsets.all(15.0),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       // TODO: 추후 필요한 경우, styled text 패키지 추가
            //       // https://pub.dev/packages/styled_text
            //       children: [
            //         RichText(
            //           text: const TextSpan(children: [
            //             TextSpan(
            //                 text: '오전 ',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.w800,
            //                     color: Color(0xFFFFBB3C))),
            //             TextSpan(
            //                 text: '출근길 빗길 조심하세요!',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.w800,
            //                     color: Colors.black))
            //           ]),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 90,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ///
                    /// 상단 안내문구
                    ///
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "아무개님🥰",
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                "날씨가 맑네요. 하지만 오후에 비 예보가 있습니다!",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    height: 1.5),
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
                          child: Image.asset("assets/images/dog.png"),
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
                    SizedBox(
                      width: 180,
                      height: 180,
                      child:
                          weatherStatus(weather.result[0]['weatherStatusCode']),
                    ),
                    Center(
                      child: Text(
                        (isLoading)
                            ? weather.result[0]['temp'].toString() + '℃'
                            : '...',
                        style: const TextStyle(
                            height: 2,
                            fontSize: 40,
                            fontWeight: FontWeight.w800),
                      ),
                    ),

                    ///
                    /// 하단 날씨위젯
                    ///
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Builder(
                        builder: (_) {
                          List<Widget> result = [];
                          for (int i = 0; i < 6; i++) {
                            result.add(weatherTile(
                              context: context,
                              title:
                                  (i == 0) ? '현재' : '+' + i.toString() + '시간',
                              color: const Color(0xFFFFAE9A),
                              temper: (isLoading)
                                  ? weather.result[0]['temp'].toString() + '℃'
                                  : '...',
                              icon: weatherStatus(
                                  weather.result[0]['weatherStatusCode']),
                            ));
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: result,
                          );
                        },
                      ),
                      height: 100,
                    ),
                    const SizedBox(height: 10),

                    ///
                    /// MY 리스트
                    ///
                    const Text(
                      "MY 리스트\n",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // RouteInfo(
                            //     idx: 0,
                            //     title: Text('소요시간'),
                            //     subtitle: Row(
                            //       children: [
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/walk.png'),
                            //         ),
                            //         Text('도보 ➔ '),
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/bus-normal.png'),
                            //         ),
                            //         Text('버스 ➔ '),
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/subway-gyeongchun.png'),
                            //         ),
                            //         Text('지하철 ➔ '),
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/subway-1-line.png'),
                            //         ),
                            //         Text('지하철'),
                            //       ],
                            //     ),
                            //     isEnable: false),
                            // RouteInfo(
                            //     idx: 1,
                            //     title: Text('소요시간'),
                            //     subtitle: Row(
                            //       children: [
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/bus-town.png'),
                            //         ),
                            //         Text('버스 ➔ '),
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/walk.png'),
                            //         ),
                            //         Text('도보 ➔ '),
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/subway-2-line.png'),
                            //         ),
                            //         Text('지하철')
                            //       ],
                            //     ),
                            //     isEnable: false),
                            // RouteInfo(
                            //     title: Text('소요시간'),
                            //     subtitle: Row(
                            //       children: [
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/bus-metro.png'),
                            //         ),
                            //         Text('버스 ➔ '),
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/subway-3-line.png'),
                            //         ),
                            //         Text('지하철')
                            //       ],
                            //     ),
                            //     isEnable: false),
                            // RouteInfo(
                            //     title: Text('소요시간'),
                            //     subtitle: Row(
                            //       children: [
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/walk.png'),
                            //         ),
                            //         Text('도보 ➔ '),
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/bus-trunk.png'),
                            //         ),
                            //         Text('버스 ➔ '),
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/subway-gyeongchun.png'),
                            //         ),
                            //         Text('지하철')
                            //       ],
                            //     ),
                            //     isEnable: false),
                            // RouteInfo(
                            //     title: Text('소요시간'),
                            //     subtitle: Row(
                            //       children: [
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/subway-jungang.png'),
                            //         ),
                            //         Text('지하철 ➔ '),
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/bus-airport.png'),
                            //         ),
                            //         Text('버스'),
                            //       ],
                            //     ),
                            //     isEnable: false),
                            // RouteInfo(
                            //     title: Text('소요시간'),
                            //     subtitle: Row(
                            //       children: [
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/subway-6-line.png'),
                            //         ),
                            //         Text('지하철 ➔ '),
                            //         SizedBox(
                            //           width: 15,
                            //           height: 15,
                            //           child: Image.asset(
                            //               'assets/icons/transport/bus-etc.png'),
                            //         ),
                            //         Text('버스'),
                            //       ],
                            //     ),
                            //     isEnable: false),
                            CandyButton(
                              width: 72,
                              height: 72,
                              borderRadius: 72,
                              buttonColor: const Color(0xFF858D8D),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 32,
                              ),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SelectDestionationView(),
                                ),
                              ),
                            ),
                            CandyButton(
                                child: const Text("test"),
                                onPressed: () {
                                  List<Alarm> alarms = prefs.readAlarm();

                                  print(alarms[0].alarmDOTW);
                                  print(alarms[0].alarmName);
                                  print(alarms[0].alarmTime);
                                  print(alarms[0].pathNodeList);
                                })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Image weatherStatus(int weatherStatusCode) {
    switch (weatherStatusCode) {
      case 1:
        return Image.asset('assets/icons/weather/weather-mostly-sunny.png');
      case 2:
        return Image.asset('assets/icons/weather/weather-partly_cloudy.png');
      case 3:
        return Image.asset('assets/icons/weather/weather-rainy.png');
      case 4:
        return Image.asset('assets/icons/weather/weather-stromy.png');
      case 5:
        return Image.asset('assets/icons/weather/weather-snowy.png');
      case 6:
        return Image.asset('assets/icons/weather/weather-cloudy.png');
      default:
        return Image.asset('assets/icons/weather/weather-sunny.png');
    }
  }
}

Widget weatherTile(
        {required BuildContext context,
        required String title,
        required Color color,
        required String temper,
        required Image icon
        // String imagePath
        }) =>
    Container(
      width: (MediaQuery.of(context).size.width - 60) * 0.14,
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
            child: icon,
          ),
          Text(temper),
        ],
      ),
    );

class WeatherColors {
  static Color sunny = const Color(0xFFFCE8D8);
  static Color sunnyTile = const Color(0xFFFFAE9A);
  static Color mostlySunny = const Color(0xFFFFF1D9);
  static Color mostlySunnyTile = const Color(0xFFFFC388);
  static Color partlyCloudy = const Color(0xFFEBF7FF);
  static Color partlyCloudyTile = const Color(0xFF8DD1DD);
  static Color rainy = const Color(0xFFDDEEFF);
  static Color rainyTile = const Color(0xFF70BCD8);
  static Color stromy = const Color(0xFFDBE2E5);
  static Color stromyTile = const Color(0xFF9DC4CB);
  static Color snowy = const Color(0xFFFFFFFF);
  static Color snowyTile = const Color(0xFFD6E7EA);
  static Color cloudy = const Color(0xFFEDF2F8);
  static Color cloudyTile = const Color(0xFFABD4DB);
  static List<Color> backColors = [
    sunny,
    mostlySunny,
    partlyCloudy,
    rainy,
    stromy,
    snowy,
    cloudy
  ];
  static List<Color> tileColors = [
    sunnyTile,
    mostlySunnyTile,
    partlyCloudyTile,
    rainyTile,
    stromyTile,
    snowyTile,
    cloudyTile
  ];
}
