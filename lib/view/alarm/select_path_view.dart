import 'package:app/util/route.dto.dart';
import 'package:app/util/route.vo.dart';
import 'package:app/util/%08utils.dart';
import 'package:app/view/alarm/path_detail_view.dart';
import 'package:app/view/alarm/widgets/route_info_list.dart';

import 'package:cotton_candy_ui/cotton_candy_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Coordinate {
  Coordinate({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;
}

class SelectPathView extends StatefulWidget {
  final String startAddress;
  final String endAddress;

  final Coordinate startPoint;
  final Coordinate endPoint;

  const SelectPathView({
    Key? key,
    required this.startAddress,
    required this.endAddress,
    required this.startPoint,
    required this.endPoint,
  }) : super(key: key);

  @override
  _SelectPathViewState createState() => _SelectPathViewState();
}

class _SelectPathViewState extends State<SelectPathView> {
  @override
  void initState() {
    getPathWidgets(
      startPoint: widget.startPoint,
      endPoint: widget.endPoint,
      transportationType: TransportationType.all,
    ).then((value) {
      pathResults = value;
      setState(() {});
    });

    super.initState();
  }

  List<RouteInfoItem> pathResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('출근 경로', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFFCE8D8),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      backgroundColor: const Color(0xFFFCE8D8),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 52),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 346,
                height: 47,
                child: Row(
                  children: [
                    const SizedBox(width: 60, child: Center(child: Text('출발'))),
                    Text(widget.startAddress.length > 24
                        ? "${widget.startAddress.substring(0, 24)}..."
                        : widget.startAddress),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 346,
                height: 47,
                child: Row(
                  children: [
                    const SizedBox(width: 60, child: Center(child: Text('도착'))),
                    Text(widget.endAddress.length > 24
                        ? "${widget.endAddress.substring(0, 24)}..."
                        : widget.endAddress),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 2,
                thickness: 2,
                color: Color(0xFFF2F2F2),
              ),
              const SizedBox(height: 10),
              CandyRadioButton(
                width: 90,
                selectedButtonColor: const Color(0xFFFECEC0),
                selectedTextColor: Colors.black,
                radioComponents: const ['최단경로', '지하철', '버스'],
                onChanged: (value) {
                  pathResults.clear();
                  setState(() {});

                  late TransportationType trType;

                  switch (value) {
                    case "지하철":
                      trType = TransportationType.subway;
                      break;
                    case "버스":
                      trType = TransportationType.bus;
                      break;
                    default:
                      trType = TransportationType.all;
                      break;
                  }

                  getPathWidgets(
                    startPoint: widget.startPoint,
                    endPoint: widget.endPoint,
                    transportationType: trType,
                  ).then((value) {
                    pathResults = value;
                    setState(() {});
                  });
                },
              ),
              const SizedBox(height: 10),
              const Divider(
                height: 2,
                thickness: 2,
                color: Color(0xFFF2F2F2),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 430,
                child: RouteInfoList(
                  routeInfos: [...pathResults],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CandyButton(
                      height: 55,
                      width: 346,
                      child: const Text(
                        '경로 적용',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      buttonColor: const Color(0xFFFECFC3),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PathDetailView(
                            startAddress: widget.startAddress,
                            endAddress: widget.endAddress,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<bool> isSelected = [];

  Future<List<RouteInfoItem>> getPathWidgets({
    required Coordinate startPoint,
    required Coordinate endPoint,
    required TransportationType transportationType,
  }) async {
    List<PathNodeList> result = await RouteDTO.get(
      startX: startPoint.longitude,
      startY: startPoint.latitude,
      endX: endPoint.longitude,
      endY: endPoint.latitude,
      transportationType: transportationType,
    );

    for (PathNodeList v in result) {
      List<Widget> subtitle = [];

      for (PathNode n in v.transportation) {
        if (n is PathNodeBus) {
          PathNodeBus nn = n;
          subtitle.add(
            SizedBox(
              width: 15,
              height: 15,
              child: busType(nn.busType),
            ),
          );
          subtitle.add(Text(' ${nn.name}',
              style: const TextStyle(color: Color(0xFF707071), fontSize: 12)));
        } else if (n is PathNodeSubway) {
          PathNodeSubway nn = n;
          subtitle.add(
            SizedBox(
              width: 15,
              height: 15,
              child: subwayType(nn.lineId),
            ),
          );
          subtitle.add(Text(' ${nn.name}',
              style: const TextStyle(color: Color(0xFF707071), fontSize: 12)));
        } else if (n is PathNodeWalk) {
          PathNodeWalk nn = n;
          subtitle.add(
            SizedBox(
              width: 15,
              height: 15,
              child: Image.asset('assets/icons/transport/walk.png'),
            ),
          );
          subtitle.add(const Text(
            ' 도보',
            style: TextStyle(color: Color(0xFF707071), fontSize: 12),
          ));
        } else {}

        subtitle.add(const Text(
          ' ➔ ',
          style: TextStyle(color: Color(0xFF707071), fontSize: 12),
        ));
      }
      subtitle.removeLast();

      isSelected.add(false);

      pathResults.add(
        RouteInfoItem(
          title: Text(
            minuteToHour(v.durationTime),
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black),
          ),
          subTitle: subtitle,
        ),
      );
    }

    return pathResults;
  }
}
