import 'package:cotten_candy_ui/cotten_candy_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Splash view"),

            ///
            ///
            ///
            ///
            ///

            CandyButton(
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, "/alarm"),
              width: 50,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
