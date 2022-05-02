import 'package:flutter/material.dart';

class FunctionalIcon extends StatefulWidget {
  Function? tapFunction = () {};
  Function? doubletapFunction = () {};
  Widget icon;
  Color? primaryColor = Color.fromARGB(255, 73, 73, 73);
  bool animate = true;
  bool coloring = true;
  double size = 48;
  FunctionalIcon(
      {required this.icon,
      this.tapFunction,
      this.doubletapFunction,
      this.primaryColor,
      this.animate = true,
      this.coloring = true,
      this.size = 48});

  @override
  State<FunctionalIcon> createState() => _FunctionalIconState();
}

class _FunctionalIconState extends State<FunctionalIcon> {
  bool ishovering = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
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
              padding: EdgeInsets.all((ishovering && widget.animate) ? 6 : 2),
              decoration: BoxDecoration(
                  color: (ishovering && widget.coloring)
                      ? Colors.amber[400]
                      : widget.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(color: Colors.black, width: 1)),
              child: widget.icon),
        ),
      ),
    );
  }
}
