import 'dart:async';
import 'package:cotten_candy_ui/cotten_candy_ui.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // @override
  // void initState() {
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:const Color(0xFFFCE8D8),
      body:Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('main page\n', style: TextStyle(fontSize: 50),),
          CandyButton(onPressed: () {},
          child: const Text('나의 시작길 입력하기', style: TextStyle(color:CandyColors.candyPink,),),buttonColor: Color(0xFFFFFFFF),)
        ],
      ),)
    );
  }
}
