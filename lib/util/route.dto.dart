import 'package:app/util/route.vo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RouteDTO {
  static Future<List<PathNodeList>> get({
    required double startX,
    required double startY,
    required double endX,
    required double endY,
    required TransportationType transportationType,
  }) async {
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
      List<PathNodeList> pathNodeLists = [];

      List<dynamic> raws = jsonDecode(utf8.decode(response.bodyBytes));

      for (dynamic o in raws) {
        List<dynamic> rawPathNodes = o['pathNodeList'];
        int durationTime = o['durationTime'];
        List<PathNode> pathNodes = [];

        for (Map<String, dynamic> p in rawPathNodes) {
          switch (p['transportation']) {
            case "subway":
              pathNodes.add(
                pathNodeSubway(
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
                pathNodeBus(
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
              pathNodes.add(pathNodeWalk(walkMeter: p['walkMeter']));
              break;
          }
        }

        pathNodeLists.add(PathNodeList(
            durationTime: durationTime, transportation: pathNodes));
      }

      return pathNodeLists;
    } else {
      throw Exception('Fail to load data...${response.statusCode}');
    }
  }
}

enum TransportationType { all, subway, bus }
