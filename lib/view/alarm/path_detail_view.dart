import 'package:app/util/route.vo.dart';
import 'package:app/view/alarm/time_setting_view.dart';
import 'package:app/view/alarm/widgets/route_info.dart';
import 'package:cotton_candy_ui/cotton_candy_ui.dart';
import 'package:flutter/material.dart';
import 'select_path_view.dart';

class PathDetailView extends StatefulWidget {
  final PathNodeList selectedRoute;
  final String startAddress;
  final String endAddress;
  const PathDetailView(
      {required this.startAddress,
      required this.endAddress,
      required this.selectedRoute,
      Key? key})
      : super(key: key);

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
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  widget.startAddress,
                  style: const TextStyle(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
            const Text(
              ' > ',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                  widget.endAddress,
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
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 52),
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
              // child:
              // SingleChildScrollView(
              //   physics: const BouncingScrollPhysics(),
              child: Builder(builder: (_) {
                List<CandyIndicator> nodes = [];

                for (PathNode node in widget.selectedRoute.transportation) {
                  if (node is PathNodeBus) {
                    nodes.add(CandyIndicator(
                      child: const Icon(
                        Icons.directions_bus,
                        color: Colors.white,
                      ),
                      title: Text(node.startStationName),
                      subTitle: Text(node.name),
                    ));
                  } else if (node is PathNodeSubway) {
                    nodes.add(CandyIndicator(
                      child: const Icon(
                        Icons.directions_subway,
                        color: Colors.white,
                      ),
                      title: Text(node.startStationName),
                      subTitle: Text(node.name),
                    ));
                  } else if (node is PathNodeWalk) {
                    nodes.add(CandyIndicator(
                      child: const Icon(
                        Icons.directions_run,
                        color: Colors.white,
                      ),
                      title: const Text('도보'),
                      subTitle: Text(node.walkMeter.toString() + 'm'),
                    ));
                  } else {}
                }

                return Container(height: 500,
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
              // ),
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
                        builder: (context) => const TimeSettingView(),
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

// Widget writeSubtitle(PathNodeList? nodes) {
//     List<Widget> subtitle = [];
//     for (PathNode node in nodes!.transportation) {
//       if (node is PathNodeBus) {
//         PathNodeBus nn = node;
//         subtitle.add(
//           SizedBox(
//             width: 15,
//             height: 15,
//             child: busType(nn.busType),
//           ),
//         );
//         subtitle.add(Text(' ${nn.name}',
//             style: const TextStyle(color: Color(0xFF707071), fontSize: 12)));
//       } else if (node is PathNodeSubway) {
//         PathNodeSubway nn = node;
//         subtitle.add(
//           SizedBox(
//             width: 15,
//             height: 15,
//             child: subwayType(nn.lineId),
//           ),
//         );
//         subtitle.add(Text(' ${nn.name}',
//             style: const TextStyle(color: Color(0xFF707071), fontSize: 12)));
//       } else if (node is PathNodeWalk) {
//         subtitle.add(
//           SizedBox(
//             width: 15,
//             height: 15,
//             child: Image.asset('assets/icons/transport/walk.png'),
//           ),
//         );
//         subtitle.add(const Text(
//           ' 도보',
//           style: TextStyle(color: Color(0xFF707071), fontSize: 12),
//         ));
//       } else {}
//       subtitle.add(const Text(
//         ' ➔ ',
//         style: TextStyle(color: Color(0xFF707071), fontSize: 12),
//       ));
//     }
//     subtitle.removeLast();
//     return
//     Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: subtitle,
//     );
//   }
