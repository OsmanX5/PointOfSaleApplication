import 'package:flutter/material.dart';

class HotRestartController extends StatefulWidget {
  final Widget child;

  HotRestartController({required this.child});

  static performHotRestart(BuildContext context) {
    if (context.findAncestorStateOfType<_HotRestartControllerState>() != null) {
      final _HotRestartControllerState? state =
          context.findAncestorStateOfType<_HotRestartControllerState>();
      state?.performHotRestart();
    }
  }

  @override
  _HotRestartControllerState createState() => new _HotRestartControllerState();
}

class _HotRestartControllerState extends State<HotRestartController> {
  Key key = new UniqueKey();

  void performHotRestart() {
    this.setState(() {
      key = new UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      key: key,
      child: widget.child,
    );
  }
}
