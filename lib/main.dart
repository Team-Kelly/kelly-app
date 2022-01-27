import 'package:flutter/material.dart';
//import 'view/splash.dart';
import 'view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
      routes: {
        //'/splash': (context) => SplashView(),
        '/home': (context) => HomeView(),
      },
    );
  }
}
