import 'package:app/view/alarm/select_destination_view.dart';
import 'package:app/view/alarm/path_detail_view.dart';
// import 'package:app/view/main/home_view.dart';
import 'package:cotten_candy_ui/cotten_candy_ui.dart';
import 'package:flutter/material.dart';

class SelectPathView extends StatefulWidget {
  const SelectPathView({Key? key}) : super(key: key);

  @override
  _SelectPathViewState createState() => _SelectPathViewState();
}

class _SelectPathViewState extends State<SelectPathView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('출근 경로', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFFCE8D8),
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectDestionationView(),
            ),
          ),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      backgroundColor: const Color(0xFFFCE8D8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 346,
              height: 47,
              child: Row(
                children: [
                  SizedBox(width: 60, child: Center(child: Text('출발'))),
                  Text('영진그린필 아파트'),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 346,
              height: 47,
              child: Row(
                children: [
                  SizedBox(width: 60, child: Center(child: Text('도착'))),
                  Text('광운대학교'),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            const SizedBox(height: 10),
            CandyRadioButton(
              selectedButtonColor: const Color(0xFFFECEC0),
              selectedTextColor: Colors.black,
              radioComponents: const ['최단경로', '지하철', '버스'],
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 450,
              // color: Colors.blue,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    routeInfo(
                        title: Text(
                          '소요시간',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Row(
                          children: [
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/walk.png'),
                            ),
                            Text('도보 > '),
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/bus-normal.png'),
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
                              child: Image.asset(
                                  'assets/icons/transport/subway-1-line.png'),
                            ),
                            Text('지하철'),
                          ],
                        )),
                    routeInfo(
                        title: Text(
                          '소요시간',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Row(
                          children: [
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/bus-town.png'),
                            ),
                            Text('버스 > '),
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/walk.png'),
                            ),
                            Text('도보 > '),
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/subway-2-line.png'),
                            ),
                            Text('지하철')
                          ],
                        )),
                    routeInfo(
                        title: Text(
                          '소요시간',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Row(
                          children: [
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/bus-metro.png'),
                            ),
                            Text('버스 > '),
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/subway-3-line.png'),
                            ),
                            Text('지하철')
                          ],
                        )),
                    routeInfo(
                        title: Text(
                          '소요시간',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Row(
                          children: [
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/walk.png'),
                            ),
                            Text('도보 > '),
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/bus-trunk.png'),
                            ),
                            Text('버스 > '),
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/subway-gyeongchun.png'),
                            ),
                            Text('지하철')
                          ],
                        )),
                    routeInfo(
                        title: Text(
                          '소요시간',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Row(
                          children: [
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/subway-jungang.png'),
                            ),
                            Text('지하철 > '),
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/bus-airport.png'),
                            ),
                            Text('버스'),
                          ],
                        )),
                    routeInfo(
                        title: Text(
                          '소요시간',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        subtitle: Row(
                          children: [
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/subway-6-line.png'),
                            ),
                            Text('지하철 > '),
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Image.asset(
                                  'assets/icons/transport/bus-etc.png'),
                            ),
                            Text('버스'),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CandyButton(
              width: 346,
              child: const Text(
                '경로 적용',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              buttonColor: const Color(0xFFFECFC3),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PathDetailView(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget routeInfo({
  required Widget title,
  required Widget subtitle,
}) =>
    SizedBox(
      width: 346,
      height: 83,
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                title: title,
                subtitle: subtitle,
              ),
            ),
          ],
        ),
      ),
    );
