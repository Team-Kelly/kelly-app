import 'package:app/util/route.vo.dart';
import 'package:app/view/alarm/widgets/route_info.dart';
import 'package:flutter/material.dart';

class RouteInfoList extends StatefulWidget {
  final List<dynamic> routeInfos;
  final Function(PathNodeList)? onChanged;

  const RouteInfoList(
      {Key? key, required this.routeInfos, required this.onChanged})
      : super(key: key);

  @override
  State<RouteInfoList> createState() => _RouteInfoListState();
}

class _RouteInfoListState extends State<RouteInfoList> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (_) {
      List<Widget> children = [];
      for (int i = 0; i < widget.routeInfos.length; i++) {
        children.add(RouteInfo(
          nodeList: widget.routeInfos[i],
          isEnable: (i == selectedIndex) ? true : false,
          onPressed: (value) {
            setState(() {
              selectedIndex = i;
            });
            // print(selectedIndex);
            widget.onChanged!(value);
          },
        ));
      }
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: children,
        ),
      );
    });
  }
}
