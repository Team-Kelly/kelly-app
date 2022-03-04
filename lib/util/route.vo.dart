class PathNodeList {
  PathNodeList({
    required this.transportation,
    required this.durationTime,
  });

  List<PathNode> transportation;
  int durationTime;

  @override
  String toString() {
    return "{transportation: $transportation, durationTime: $durationTime,}";
  }
}

abstract class PathNode {
  PathNode({
    required this.startStationName,
    required this.endStationName,
    required this.stationCnt,
    required this.name,
  });

  String startStationName;
  String endStationName;
  int stationCnt;
  String name;

  @override
  String toString() {
    return "{startStationName: $startStationName, endStationName: $endStationName, stationCnt: $stationCnt, name: $name, }";
  }
}

class pathNodeBus extends PathNode {
  pathNodeBus({
    required String name,
    required String startStationName,
    required String endStationName,
    required int stationCnt,
    required this.busId,
    required this.busType,
    required this.busTypeDetail,
    required this.startStationId,
    required this.cityCode,
  }) : super(
          name: name,
          startStationName: startStationName,
          stationCnt: stationCnt,
          endStationName: endStationName,
        );

  String busId;
  int busType;
  String busTypeDetail;
  String startStationId;
  String cityCode;

  @override
  String toString() {
    return "{name: $name, startStationName: $startStationName, endStationName: $endStationName, stationCnt: $stationCnt, busId: $busId, busType: $busType, busTypeDetail: $busTypeDetail, startStationId: $startStationId, cityCode: $cityCode}";
  }
}

class pathNodeSubway extends PathNode {
  pathNodeSubway({
    required String name,
    required String startStationName,
    required String endStationName,
    required int stationCnt,
    required this.startStationId,
    required this.direction,
    required this.lineId,
  }) : super(
          name: name,
          startStationName: startStationName,
          stationCnt: stationCnt,
          endStationName: endStationName,
        );

  String startStationId;
  String direction;
  String lineId;

  @override
  String toString() {
    return "{name: $name, startStationName: $startStationName, endStationName: $endStationName, stationCnt: $stationCnt, startStationId: $startStationId, direction: $direction, lineId: $lineId}";
  }
}

class pathNodeWalk extends PathNode {
  pathNodeWalk({
    required this.walkMeter,
  }) : super(
            name: 'none',
            startStationName: 'none',
            stationCnt: -1,
            endStationName: 'none');

  int walkMeter;

  @override
  String toString() {
    return "{walkMeter: $walkMeter}";
  }
}
