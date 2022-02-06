import 'package:flutter/material.dart';
import 'view/home.dart';
import 'view/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
      routes: {
        '/home': (context) => const HomeView(),
        '/search': (context) => const Search(),
      },
    );
  }
}
