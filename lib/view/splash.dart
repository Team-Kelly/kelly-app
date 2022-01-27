// import 'dart:async';
// import 'package:app/view/home.dart';
// import 'package:flutter/material.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({ Key? key }) : super(key: key);

//   @override
//   _SplashViewState createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(milliseconds: 1500), () {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => HomeView())).then((value) => Navigator.pop(context));
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: const Color(0xFFFCE8D8),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/logo.png',
//                 width: MediaQuery.of(context).size.width * 0.5,
//                 height: MediaQuery.of(context).size.height * 0.29,
//               ),
//               SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//               Image.asset(
//                 'assets/title.png',
//                 width: MediaQuery.of(context).size.width * 0.7,
//                 height: MediaQuery.of(context).size.height * 0.064,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
