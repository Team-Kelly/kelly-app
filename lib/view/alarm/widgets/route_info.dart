import 'package:app/util/route.vo.dart';
import 'package:app/util/utils.dart';
import 'package:cotton_candy_ui/cotton_candy_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteInfo extends StatefulWidget {
  const RouteInfo({
    Key? key,
    required this.nodeList,
    required this.isEnable,
    this.onPressed,
  }) : super(key: key);

  final bool isEnable;
  final PathNodeList nodeList;
  final Function(PathNodeList)? onPressed;
  // final VoidCallback? onPressed;

  @override
  State<RouteInfo> createState() => _RouteInfoState();
}

class _RouteInfoState extends State<RouteInfo> {
  Widget writeSubtitle(PathNodeList? nodes) {
    List<Widget> subtitle = [];
    for (PathNode node in nodes!.transportation) {
      if (node is PathNodeBus) {
        PathNodeBus nn = node;
        subtitle.add(
          SizedBox(
            width: 15,
            height: 15,
            child: busType(nn.busType),
          ),
        );
        subtitle.add(Text(' ${nn.name}',
            style: const TextStyle(color: Color(0xFF707071), fontSize: 12)));
      } else if (node is PathNodeSubway) {
        PathNodeSubway nn = node;
        subtitle.add(
          SizedBox(
            width: 15,
            height: 15,
            child: subwayType(nn.lineId),
          ),
        );
        subtitle.add(Text(' ${nn.name}',
            style: const TextStyle(color: Color(0xFF707071), fontSize: 12)));
      } else if (node is PathNodeWalk) {
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
    return 
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: subtitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 1,
      padding: widget.isEnable
          ? const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0)
          : const EdgeInsets.all(4.0),
      onPressed: () {
        setState(() {

        });
        // print(widget.nodeList);
        // if (widget.isEnable == true) {
          widget.onPressed!(widget.nodeList);
        // } 
      },
      child: SizedBox(
        width: 346,
        height: 83,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          decoration: BoxDecoration(
            color: widget.isEnable ? const Color(0xFFFFF8F8) : Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: widget.isEnable
                ? Border.all(width: 4.0, color: CandyColors.candyPink)
                : null,
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.07),
                offset: Offset(3, 3),
                blurRadius: 10,
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  minuteToHour(widget.nodeList.durationTime),
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
                SingleChildScrollView(scrollDirection :Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: writeSubtitle(widget.nodeList),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
