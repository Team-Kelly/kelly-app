import 'package:app/view/alarm/widgets/route_info.dart';
import 'package:app/view/alarm/time_setting_view.dart';
import 'package:cotton_candy_ui/cotton_candy_ui.dart';
import 'package:app/util/route.vo.dart';
import 'package:flutter/material.dart';

class PathDetailView extends StatefulWidget {
  final PathNodeList selectedRoute;
  final String startKeyword;
  final String endKeyword;

  const PathDetailView({
    required this.selectedRoute,
    required this.startKeyword,
    required this.endKeyword,
    Key? key,
  }) : super(key: key);

  @override
  _PathDetailViewState createState() => _PathDetailViewState();
}

class _PathDetailViewState extends State<PathDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFFFFFF),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                // width: MediaQuery.of(context).size.width / 3,
                child: Text(
              widget.startKeyword,
              style: const TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )),
            const Text(
              ' ➔ ',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
                // width: MediaQuery.of(context).size.width / 3,
                child: Text(
              widget.endKeyword,
              style: const TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RouteInfo(nodeList: widget.selectedRoute, isEnable: false),
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 3,
              color: const Color(0xFFF2F2F2),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(50, 20, 50, 0),
              child: Builder(builder: (_) {
                List<CandyIndicator> nodes = [];

                for (PathNode node in widget.selectedRoute.transportation) {
                  if (node is PathNodeBus) {
                    nodes.add(CandyIndicator(
                      child: const Icon(
                        Icons.directions_bus,
                        color: Colors.white,
                      ),
                      title: Text(
                        (node.startStationName.length > 22)
                            ? "${node.startStationName.substring(0, 22)}..."
                            : node.startStationName,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w900),
                      ),
                      subTitle: Text(
                        node.name,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ));
                  } else if (node is PathNodeSubway) {
                    nodes.add(CandyIndicator(
                      child: const Icon(
                        Icons.directions_subway,
                        color: Colors.white,
                      ),
                      title: Text(
                        (node.startStationName.length > 22)
                            ? "${node.startStationName.substring(0, 22)}..."
                            : node.startStationName,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w900),
                      ),
                      subTitle: Text(
                        node.name,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ));
                  } else if (node is PathNodeWalk) {
                    nodes.add(CandyIndicator(
                      child: const Icon(
                        Icons.directions_run,
                        color: Colors.white,
                      ),
                      title: const Text(
                        '도보',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w900),
                      ),
                      subTitle: Text(
                        node.walkMeter.toString() + 'm',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ));
                  } else {}
                }

                return SizedBox(
                  height: MediaQuery.of(context).size.height * (4 / 7),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: CandyTimeLine(
                      children: nodes,
                      connector: const CandyConnector(
                        height: 50,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CandyButton(
                    height: 55,
                    width: 346,
                    child: const Text(
                      '경로 추가',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimeSettingView(
                          startKeyword: widget.startKeyword,
                          endKeyword: widget.endKeyword,
                          pathNodeList: widget.selectedRoute,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
