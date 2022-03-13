import 'package:app/util/route.dto.dart';
import 'package:app/util/route.vo.dart';
import 'package:app/util/utils.dart';
import 'package:app/view/alarm/path_detail_view.dart';
import 'package:app/view/alarm/widgets/route_info_list.dart';
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
  final String startKeyword;
  final String endKeyword;
  final Coordinate startPoint;
  final Coordinate endPoint;

  const SelectPathView({
    Key? key,
    required this.startAddress,
    required this.endAddress,
    required this.startPoint,
    required this.endPoint,
    required this.startKeyword,
    required this.endKeyword,
  }) : super(key: key);

  @override
  _SelectPathViewState createState() => _SelectPathViewState();
}

class _SelectPathViewState extends State<SelectPathView> {
  List<PathNodeList> pathResults = [];
  PathNodeList? selectedRoute;
  @override
  void initState() {
    updatePathListResults(TransportationType.all);

    super.initState();
  }

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
                onChanged: updatePathListResults,
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
                  onChanged: (value) {
                    setState(() {
                      selectedRoute = value;
                    });
                  },
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
                      buttonColor: (selectedRoute != null)
                          ? CandyColors.candyPink
                          : const Color(0xFFFECFC3),
                      onPressed: () => (selectedRoute != null)
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PathDetailView(
                                  startKeyword: widget.startKeyword,
                                  endKeyword: widget.endKeyword,
                                  selectedRoute: selectedRoute!,
                                ),
                              ),
                            )
                          : null,
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

  Future<void> updatePathListResults(value) async {
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

    try {
      pathResults = await getPathNodeLists(
        startPoint: widget.startPoint,
        endPoint: widget.endPoint,
        transportationType: trType,
      );
    } catch (err) {
      makeToast(msg: "경로 검색 결과가 없습니다");
    }
    setState(() {});
  }

  Future<List<PathNodeList>> getPathNodeLists({
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
    return result;
  }
}
