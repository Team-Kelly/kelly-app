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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),

            ///
            ///
            ///
            /// 상단 노티바
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
            ///
            ///
            /// 상단 안내문구
            SizedBox(height: 50),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image(
                    image: AssetImage(""),
                  ),
                ),
              ],
            ),

            ///
            ///
            ///
            /// 날씨 이모티콘
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Text("현위치: 서초구"),
                        Positioned(
                          left: 0,
                          right: 0,
                          height: 175,
                          child: Container(
                            height: 175,
                            width: 175,
                            child: Image(
                              image: AssetImage(""),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///
            ///
            ///
            /// 하단 날씨위젯
            SizedBox(height: 50),
            Container(
              height: 100,
              color: CandyColors.candyPink,
            ),
            SizedBox(height: 50),

            ///
            ///
            ///
            /// MY 리스트
            Text(
              "MY 리스트",
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
                      routeInfo(title: '소요시간', subtitle: '경로 상세'),
                      SizedBox(height: 5),
                      routeInfo(title: '소요시간', subtitle: '경로 상세'),
                      SizedBox(height: 5),
                      routeInfo(title: '소요시간', subtitle: '경로 상세'),
                      SizedBox(height: 5),
                      routeInfo(title: '소요시간', subtitle: '경로 상세'),
                      SizedBox(height: 5),
                      routeInfo(title: '소요시간', subtitle: '경로 상세'),
                      SizedBox(height: 5),
                      routeInfo(title: '소요시간', subtitle: '경로 상세'),
                      SizedBox(height: 5),
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
