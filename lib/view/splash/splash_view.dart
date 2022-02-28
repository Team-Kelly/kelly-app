import 'package:app/provider/personal_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    runner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE8D8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage("assets/images/splash.png"),
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> runner() async {
    PersonalInfo personalInfo =
        Provider.of<PersonalInfo>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 3000));
    if (personalInfo.isFirst) {
      await Navigator.pushReplacementNamed(context, "/alarm");
    } else {
      await Navigator.pushReplacementNamed(context, "/home");
    }
  }
}
