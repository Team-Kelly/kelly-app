import 'package:cotton_candy_ui/cotton_candy_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteInfo extends StatefulWidget {
  const RouteInfo({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isEnable,
    this.onPressed,
  }) : super(key: key);

  final bool isEnable;
  final Widget subtitle;
  final Widget title;
  final VoidCallback? onPressed;

  @override
  State<RouteInfo> createState() => _RouteInfoState();
}

class _RouteInfoState extends State<RouteInfo> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 1,
      padding: widget.isEnable
          ? const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0)
          : const EdgeInsets.all(4.0),
      onPressed: widget.onPressed,
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                widget.title,
                widget.subtitle,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
