import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String minuteToHour(int durationTime) {
  int hour = durationTime ~/ 60;
  int minute = durationTime % 60;
  if (hour > 0) {
    String result = hour.toString() + '시간 ' + minute.toString() + '분';
    return result;
  } else {
    String result = minute.toString() + '분';
    return result;
  }
}

Image busType(int busType) {
  if (busType == 2 ||
      busType == 4 ||
      busType == 6 ||
      busType == 22 ||
      busType == 14 ||
      busType == 15) {
    return Image.asset('assets/icons/transport/bus/metro.png');
  } else if (busType == 1 || busType == 12) {
    return Image.asset('assets/icons/transport/bus/normal.png');
  } else if (busType == 3 || busType == 13) {
    return Image.asset('assets/icons/transport/bus/town.png');
  } else if (busType == 5) {
    return Image.asset('assets/icons/transport/bus/airport.png');
  } else if (busType == 11) {
    return Image.asset('assets/icons/transport/bus/trunk.png');
  } else {
    return Image.asset('assets/icons/transport/bus/etc.png');
  }
}

Image subwayType(String lineId) {
  try {
    return Image.asset('assets/icons/transport/subway/' + lineId + '-line.png');
  } catch (e) {
    return Image.asset('assets/icons/transport/subway-yongin.png');
  }
  // 아래는 아직 lineid가 없는 애들
  // switch (pathNodeSubway.name.trim()) {
  //   case '수도권 경강선':
  //     return Image.asset('assets/icons/transport/subway-gyeonggang.png');
  //   case '수도권 에버라인':
  //     return Image.asset('assets/icons/transport/subway-yongin.png');
  //   case '수도권 의정부경전철':
  //     return Image.asset('assets/icons/transport/subway-uijeongbu.png');
  //   case '수도권 김포골드라인':
  //     return Image.asset('assets/icons/transport/subway-gimpo.png');
  //   case '인천 1호선':
  //     return Image.asset('assets/icons/transport/subway-1-incheon.png');
  //   case '인천 2호선':
  //     return Image.asset('assets/icons/transport/subway-2-incheon.png');
  //   default:  // 서해
  //     return Image.asset('assets/icons/transport/subway-seohae.png');
  // }
}

makeToast({required String msg}) => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black.withAlpha(127),
      textColor: Colors.white,
      fontSize: 16.0,
    );
