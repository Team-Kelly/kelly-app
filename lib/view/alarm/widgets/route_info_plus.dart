import 'package:app/util/preference_manager.dart';
import 'package:app/util/route.vo.dart';
import 'package:app/util/utils.dart';
import 'package:cotton_candy_ui/cotton_candy_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteInfoPlus extends StatefulWidget {
  const RouteInfoPlus({
    Key? key,
    required this.nodeList,
    required this.isEnable,
    required this.alarm,
    this.onPressed,
  }) : super(key: key);

  final Alarm alarm;
  final bool isEnable;
  final PathNodeList nodeList;
  final Function(PathNodeList)? onPressed;
  // final VoidCallback? onPressed;

  @override
  State<RouteInfoPlus> createState() => _RouteInfoPlusState();
}

class _RouteInfoPlusState extends State<RouteInfoPlus> {
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
      }
      subtitle.add(const Text(
        ' ➔ ',
        style: TextStyle(color: Color(0xFF707071), fontSize: 12),
      ));
    }
    subtitle.removeLast();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: subtitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 1,
      padding: const EdgeInsets.all(4.0),
      onPressed: () {
        if (widget.onPressed != null) {
          widget.onPressed!(widget.nodeList);
        }
      },
      child: SizedBox(
        width: 346,
        height: 83,
        child: Container(
          padding: widget.isEnable ? EdgeInsets.all(0) : EdgeInsets.all(4.0),
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
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                width: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                widget.alarm.alarmTime.hour >= 12 ? "pm" : "am",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextSpan(
                            text:
                                "${widget.alarm.alarmTime.hour > 12 ? widget.alarm.alarmTime.hour - 12 : widget.alarm.alarmTime.hour}:${widget.alarm.alarmTime.minute > 10 ? widget.alarm.alarmTime.minute : "0" + widget.alarm.alarmTime.minute.toString()}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                      child: Text(
                        dotwName(widget.alarm.alarmDOTW),
                        style: TextStyle(
                          color: CandyColors.candyPink,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // title
                    Text(
                      widget.alarm.alarmName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: writeSubtitle(widget.nodeList),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String dotwName(List<bool> dotw) {
    if (dotw.toString() ==
        [true, false, false, false, false, false, true].toString()) {
      return "주말";
    } else if (dotw.toString() ==
        [false, true, true, true, true, true, false].toString()) {
      return "주중";
    } else if (dotw.toString() ==
        [true, true, true, true, true, true, true].toString()) {
      return "매일";
    } else if (dotw.toString() ==
        [false, false, false, false, false, false, false].toString()) {
      return "없음";
    } else {
      String res =
          "${dotw[0] ? '일,' : ''}${dotw[1] ? '월,' : ''}${dotw[2] ? '화,' : ''}${dotw[3] ? '수,' : ''}${dotw[4] ? '목,' : ''}${dotw[5] ? '금,' : ''}${dotw[6] ? '토,' : ''}";
      return res.substring(0, res.length - 1);
    }
  }
}
