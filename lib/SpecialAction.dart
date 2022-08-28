import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pos_labmed/SpecialButton.dart';

class SpecialButtons extends StatefulWidget {
  const SpecialButtons({Key? key}) : super(key: key);

  @override
  State<SpecialButtons> createState() => _SpecialButtonsState();
}

class _SpecialButtonsState extends State<SpecialButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [SpecialButton(buttonText: "b1")],
      ),
    );
  }
}
