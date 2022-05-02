import 'package:flutter/material.dart';
import 'package:pos_labmed/body.dart';
import 'package:pos_labmed/Header%20libs/header.dart';
import 'Database/database_screen.dart';

//########################################################
//##################THe main application window###########
//########################################################
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool databaseOpen = false;
  Widget body = Body();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 1920,
          height: 1080,
          child: Column(children: [
            Header(
              dataBaseCallBack: opendataBase,
            ),
            body,
          ]),
        ),
      ),
    );
  }

  void opendataBase() {
    databaseOpen = !databaseOpen;
    setState(() {
      body = databaseOpen ? DataBaseScreen() : Body();
    });
  }

  void refresh() {
    setState(() {});
  }
}
