import 'package:app/view/alarm/assign_alarm_view.dart';
import 'package:app/view/main/home_view.dart';
import 'package:app/view/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/temp_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Temp>(create: (context) => Temp()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 현재 다크모드 디자인이 없음
      // showSemanticsDebugger:true,
      themeMode: ThemeMode.light,
      routes: {
        "/": (_) => const SplashView(),
        "/home": (_) => const HomeView(),
        "/alarm": (_) => const AssignAlarmView(),
      },
    );
  }
}
