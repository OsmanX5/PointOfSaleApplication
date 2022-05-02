import 'package:flutter/material.dart';

class HeaderIcon extends StatefulWidget {
  Function? tapFunction = () {};
  Function? doubletapFunction = () {};
  Widget icon;
  HeaderIcon({required this.icon, this.tapFunction, this.doubletapFunction});

  @override
  State<HeaderIcon> createState() => _HeaderIconState();
}

class _HeaderIconState extends State<HeaderIcon> {
  bool ishovering = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: InkWell(
          onTap: () {
            setState(() {
              widget.tapFunction!();
            });
          },
          onHover: (hovering) {
            setState(() => ishovering = hovering);
          },
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              padding: EdgeInsets.all(ishovering ? 10 : 2),
              decoration: BoxDecoration(
                  color: ishovering ? Colors.amber[400] : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.black, width: 1)),
              child: widget.icon),
        ),
      ),
    );
  }
}
