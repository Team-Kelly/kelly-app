// import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class RequestPermission extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: ElevatedButton(
//       onPressed: () {},
//       child: Text("request permission"),
//     ));
//   }
// }

// Future<bool> isPermitted() async {
//   Map<Permission, PermissionStatus> statuses = await [
//     Permission.camera,
//     Permission.location,
//     Permission.microphone
//   ].request();

//   bool permitted = true;

//   statuses.forEach((permission, permissionStatus) {
//     if (permissionStatus.isDenied){
//       permitted = false;
//     }
//   });
//   return permitted;
// }
