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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              CandyTextField(
                onChanged: (value) {},
                labelText: '출발',
              ),
              const SizedBox(height: 20),
              CandyTextField(
                onChanged: (value) {},
                labelText: '도착',
              ),
              const SizedBox(height: 200),
              CandyButton(
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
    );
  }
}
