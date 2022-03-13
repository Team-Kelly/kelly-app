import 'package:app/util/route.vo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RouteDTO {
  static Future<List<PathNodeList>> get({
    double startX = 0,
    double startY = 0,
    double endX = 0,
    double endY = 0,
    String? raw,
    TransportationType transportationType = TransportationType.all,
  }) async {
    List<PathNodeList> pathNodeLists = [];
    List<dynamic> raws = [];

    // String 없는 경우, API 호출
    if (raw == null) {
      final http.Response response = await http.post(
        Uri.parse('http://ssh.doky.space:8081/api/navi/route'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(<String, dynamic>{
          "startX": startX.toString(),
          "startY": startY.toString(),
          "endX": endX.toString(),
          "endY": endY.toString(),
          "option": transportationType.index.toString(),
        }),
      );

      if (response.statusCode == 200) {
        raws = jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        assert(false);
        throw Exception('Fail to load data...${response.statusCode}');
      }
    } else {
      // 없는 경우, raw 값 사용

      // 배열인지 확인
      assert(raw[0] == "[" && raw[raw.length - 1] == "]", "JSON 배열로 넣어야 합니다.");

      raws = jsonDecode(raw);
    }

    for (dynamic o in raws) {
      List<dynamic> rawPathNodes = o['pathNodeList'];
      int durationTime = o['durationTime'];
      List<PathNode> pathNodes = [];

      for (Map<String, dynamic> p in rawPathNodes) {
        switch (p['transportation']) {
          case "subway":
            pathNodes.add(
              PathNodeSubway(
                direction: p['direction'],
                lineId: p['lineId'],
                startStationId: p['startStationId'],
                endStationName: p['endStationName'],
                name: p['lineName'], // TODO: 통일
                startStationName: p['startStationName'],
                stationCnt: p['stationCnt'],
              ),
            );
            break;
          case "bus":
            pathNodes.add(
              PathNodeBus(
                busId: p['busId'],
                busType: p['busType'],
                busTypeDetail: p['busTypeDetail'],
                cityCode: p['cityCode'],
                startStationId: p['startStationId'],
                endStationName: p['endStationName'],
                name: p['busName'], // TODO: 통일
                startStationName: p['startStationName'],
                stationCnt: p['stationCnt'],
              ),
            );
            break;

          case "walk":
            pathNodes.add(PathNodeWalk(walkMeter: p['walkMeter']));
            break;
        }
      }

      pathNodeLists.add(
          PathNodeList(durationTime: durationTime, transportation: pathNodes));
    }
    return pathNodeLists;
  }
}

enum TransportationType { all, subway, bus }
