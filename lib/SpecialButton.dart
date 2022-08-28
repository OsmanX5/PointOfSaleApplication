import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class SpecialButton extends StatefulWidget {
  String buttonText = "";
  Function? tapFunction = () {};
  Function? doubletapFunction = () {};

  SpecialButton(
      {required this.buttonText, this.tapFunction, this.doubletapFunction});

  @override
  State<SpecialButton> createState() => _SpecialButtonState();
}

class _SpecialButtonState extends State<SpecialButton> {
  bool ishovering = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 60,
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
              child: Text(widget.buttonText)),
        ),
      ),
    );
  }
}
