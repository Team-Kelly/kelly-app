import 'package:app/util/preference_manager.dart';
import 'package:app/util/wment.dto.dart';
import 'package:app/view/alarm/select_destination_view.dart';
import 'package:app/view/alarm/select_path_view.dart';
import 'package:app/view/alarm/widgets/route_info.dart';
import 'package:app/view/alarm/widgets/route_info_list.dart';
import 'package:app/view/alarm/widgets/route_info_plus.dart';
import 'package:cotton_candy_ui/cotton_candy_ui.dart';
import 'package:app/util/weather.vo.dart';
import 'package:app/util/weather.dto.dart';
import 'package:flutter/material.dart';
import 'package:proj4dart/proj4dart.dart';

import 'package:http/http.dart' as http;

import '../../util/route.vo.dart';
import '../../util/wment.vo.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  WeatherVO? weather;
  bool isLoading = false;
  PreferenceManager prefs = PreferenceManager.instance;
  List<PathNodeList> pathResults = [];
  List<Alarm> alarms = [];
  late Point currentPoint;
  WeatherMentionVO? wment;

  Future<void> getlist() async {
    //
    //////////////////////////////////////////////////////////////////////////////////////
    // 알람 정보 읽어오는 곳
    alarms = prefs.readAlarm();
    isLoading = false;

    // TODO: 위경도값 가져오기
    currentPoint = Point(x: 37.6576769, y: 127.3007637);

    weather = await WeatherDTO.get(
        latitude: currentPoint.x, longitude: currentPoint.y);
    isLoading = true;
    weather = weather;

    wment = await WeatherMentionDTO.get(location: currentPoint);

    setState(() {});
  }

  @override
  void initState() {
    getlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: weather == null || wment == null
          ? Colors.grey.shade200
          : WeatherColors.backColors[weather!.result[0]['weatherStatusCode']],
      body:
          // 날씨 받아오기 전 로딩 화면
          weather == null || wment == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 75,
                        height: 75,
                        child: CircularProgressIndicator(
                          strokeWidth: 10,
                          color: Colors.grey.shade100,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              : SafeArea(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///
                              /// 상단 안내문구
                              ///
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "안녕하세요 🥰",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          wment!.prop[0],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
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
                              /// 위치 표시
                              ///
                              // Container(
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Expanded(
                              //         child: Stack(
                              //           children: [
                              //             Text("현위치: ${"ddddd"}"),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(height: 30),
                              Container(
                                width: 150,
                                height: 150,
                                child: weatherStatus(
                                    weather!.result[0]['weatherStatusCode']),
                              ),
                              Center(
                                child: Text(
                                  (isLoading)
                                      ? weather!.result[0]['temp'].toString() +
                                          '℃'
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

                              Container(
                                child: Builder(
                                  builder: (_) {
                                    List<Widget> result = [];
                                    for (int i = 0; i < 6; i++) {
                                      result.add(weatherTile(
                                        context: context,
                                        title: (i == 0)
                                            ? '현재'
                                            : '+' + i.toString() + '시간',
                                        color: WeatherColors.tileColors[weather!
                                            .result[0]['weatherStatusCode']],
                                        temper: (isLoading)
                                            ? weather!.result[0]['temp']
                                                    .toString() +
                                                '℃'
                                            : '...',
                                        icon: weatherStatus(weather!.result[0]
                                            ['weatherStatusCode']),
                                      ));
                                    }
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: result,
                                    );
                                  },
                                ),
                                height: 100,
                              ),
                              SizedBox(height: 10),

                              ///
                              /// MY 리스트
                              ///
                              SizedBox(
                                height: 29,
                                child: Text(
                                  "MY 리스트\n",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              Expanded(
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    for (Alarm item in alarms)
                                      RouteInfoPlus(
                                        alarm: item,
                                        nodeList: item.pathNodeList,
                                        isEnable: false,
                                      ),
                                    Column(
                                      children: [
                                        CandyButton(
                                          width: 72,
                                          height: 72,
                                          borderRadius: 72,
                                          buttonColor: Color(0xFF858D8D),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 32,
                                          ),
                                          onPressed: () {
                                            WeatherMentionDTO.get(
                                                location: currentPoint);
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         const SelectDestionationView(),
                                            //   ),
                                            // );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
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
          Text(
            title,
            style: TextStyle(fontSize: 9, color: Colors.white),
          ),
          Container(
            width: 30,
            height: 30,
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
            child: icon,
          ),
          Text(
            temper,
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
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
