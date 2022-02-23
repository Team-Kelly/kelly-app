import 'package:app/view/alarm/select_path_view.dart';
import 'package:flutter/material.dart';
import 'package:cotten_candy_ui/cotten_candy_ui.dart';

class SelectDestionationView extends StatefulWidget {
  const SelectDestionationView({Key? key}) : super(key: key);

  @override
  _SelectDestionationViewState createState() => _SelectDestionationViewState();
}

class _SelectDestionationViewState extends State<SelectDestionationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE8D8),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text('시작이 반이다\n',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 2 / 39,
                          height: 1.5,
                          fontWeight: FontWeight.w800,
                          color: CandyColors.candyPink)),
                ]),
                CandyTextField(
                  width: MediaQuery.of(context).size.width - 60,
                  onChanged: (value) {},
                  labelText: '출발',
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40),
                CandyTextField(
                  width: MediaQuery.of(context).size.width - 60,
                  onChanged: (value) {},
                  labelText: '도착',
                ),
                const SizedBox(height: 200),
                CandyButton(
                  width: MediaQuery.of(context).size.width - 60,
                  child: const Text(
                    '나의 시작길 입력하기',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  buttonColor: const Color(0xFFFECFC3),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectPathView(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
