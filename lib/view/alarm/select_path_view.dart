import 'package:app/view/alarm/path_detail_view.dart';
import 'package:app/view/main/home_view.dart';
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
          onPressed: () {/*Navigator.pop(context);*/},
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
                    routeInfo(title: '소요시간', subtitle: '경로 상세'),
                    routeInfo(title: '소요시간', subtitle: '경로 상세'),
                    routeInfo(title: '소요시간', subtitle: '경로 상세'),
                    routeInfo(title: '소요시간', subtitle: '경로 상세'),
                    routeInfo(title: '소요시간', subtitle: '경로 상세'),
                    routeInfo(title: '소요시간', subtitle: '경로 상세'),
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
  required String title,
  required String subtitle,
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
                title: Text(title),
                subtitle: Text(subtitle),
              ),
            ),
          ],
        ),
      ),
    );
