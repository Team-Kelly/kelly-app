import 'package:app/view/alarm/select_path_view.dart';
import 'package:flutter/material.dart';
import 'package:cotton_candy_ui/cotton_candy_ui.dart';

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

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 6),
                        Icon(Icons.circle,
                            size: 7, color: CandyColors.candyPink),
                        SizedBox(width: 49),
                        Icon(Icons.circle,
                            size: 7, color: CandyColors.candyPink),
                      ],
                    ),
                    Text(
                      '시작이 반이다',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          height: 1.5,
                          fontWeight: FontWeight.w800,
                          color: CandyColors.candyPink),
                    ),
                  ],
                ),

                // TODO: CandyTextField 그림자 적용
                // TODO: CandyTextField height값 안먹음
                // TODO: labelText -> Text 위젯으로 받도록 수정
                // TODO: labelText 가 XD와 같지 않음
                // TODO: 전체적으로 텍스트가 볼드가 안먹음

                SizedBox(height: 35),

                CandyTextField(
                  width: MediaQuery.of(context).size.width - 60,
                  onChanged: (value) {},
                  labelText: '출발',
                ),
                SizedBox(height: 10),
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
                  onPressed: () => Navigator.push(
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
