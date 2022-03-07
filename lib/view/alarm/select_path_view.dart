import 'package:app/util/route.dto.dart';
import 'package:app/util/route.vo.dart';
import 'package:app/view/alarm/path_detail_view.dart';
import 'package:cotton_candy_ui/cotton_candy_ui.dart';
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

  List<Widget> pathResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('출근 경로', style: TextStyle(color: Colors.black)),
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
                    SizedBox(width: 60, child: Center(child: Text('출발'))),
                    Text(widget.startAddress),
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
                    SizedBox(width: 60, child: Center(child: Text('도착'))),
                    Text(widget.endAddress),
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
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: pathResults,
                  ),
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
                          builder: (context) => const PathDetailView(),
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
}

Future<List<Widget>> getPathWidgets({
  required Coordinate startPoint,
  required Coordinate endPoint,
  required TransportationType transportationType,
}) async {
  List<Widget> pathResults = [];
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
            child: Image.asset('assets/icons/transport/bus-normal.png'),
          ),
        );
        subtitle.add(Text('${nn.name} ➔ '));
      } else if (n is PathNodeSubway) {
        PathNodeSubway nn = n;
        subtitle.add(
          SizedBox(
            width: 15,
            height: 15,
            child: Image.asset('assets/icons/transport/subway-1-line.png'),
          ),
        );
        subtitle.add(Text('${nn.name} ➔ '));
      } else if (n is PathNodeWalk) {
        PathNodeWalk nn = n;
        subtitle.add(
          SizedBox(
            width: 15,
            height: 15,
            child: Image.asset('assets/icons/transport/walk.png'),
          ),
        );
        subtitle.add(Text('도보 ➔ '));
      } else {}
    }

    pathResults.add(
      routeInfo(
        title: Text(
          minuteToHour(v.durationTime),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        subtitle: Container(
          height: 20,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: subtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
  return pathResults;
}

String minuteToHour(int durationTime) {
  int hour = durationTime ~/ 60;
  int minute = durationTime % 60;
  String result = hour.toString() + '시간 ' + minute.toString() + '분';
  return result;
}

Widget routeInfo({
  required Widget title,
  required Widget subtitle,
}) =>
    SizedBox(
      width: 346,
      height: 83,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.07),
              offset: Offset(3, 3),
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              title,
              subtitle,
            ],
          ),
        ),
      ),
    );
