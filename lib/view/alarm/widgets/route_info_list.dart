import 'package:app/view/alarm/widgets/route_info.dart';
import 'package:flutter/material.dart';

List<bool> isEnables = [];

class RouteInfoItem {
  RouteInfoItem({
    required this.title,
    required this.subTitle,
  });
  Widget title;
  List<Widget> subTitle;
}

class RouteInfoList extends StatefulWidget {
  const RouteInfoList({
    Key? key,
    required this.routeInfos,
    physics,
  }) : super(key: key);

  final List<RouteInfoItem> routeInfos;
  final ScrollPhysics physics = const BouncingScrollPhysics();

  @override
  State<RouteInfoList> createState() => _RouteInfoListState();
}

class _RouteInfoListState extends State<RouteInfoList> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < widget.routeInfos.length; i++) {
      children.add(
        RouteInfo(
          onPressed: () {
            isEnables.clear();
            for (int i = 0; i < widget.routeInfos.length; i++) {
              isEnables.add(false);
            }
            isEnables[i] = true;
            setState(() {});
          },
          isEnable: isEnables[i],
          title: widget.routeInfos[i].title,
          subtitle: SizedBox(
            height: 20,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: widget.routeInfos[i].subTitle,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      physics: widget.physics,
      child: Column(
        children: children,
      ),
    );
  }
}
