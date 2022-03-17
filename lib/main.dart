import 'package:app/view/alarm/assign_alarm_view.dart';
import 'package:app/view/splash/splash_view.dart';
import 'package:app/view/main/home_view.dart';
import 'provider/personal_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<PersonalInfo>(create: (context) => PersonalInfo()),
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
    return Consumer<PersonalInfo>(
      builder: (context, personalInfo, child) {
        personalInfo.loadinfo();
        // alarmInfo.loadinfo();
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
      },
    );
  }
}
