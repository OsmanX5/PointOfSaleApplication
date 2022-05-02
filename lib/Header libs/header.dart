import 'package:flutter/material.dart';
import 'package:pos_labmed/Header%20libs/header_icon.dart';
import 'package:pos_labmed/customer_screen.dart';
import 'package:pos_labmed/main.dart';

class Header extends StatefulWidget {
  Function dataBaseCallBack;
  Header({Key? key, required this.dataBaseCallBack}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool databaseHover = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1920,
      height: 70,
      color: const Color.fromARGB(255, 27, 27, 27),
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Icon(
            Icons.close_rounded,
            size: 64,
            color: Colors.red,
          ),
          const Icon(
            Icons.biotech,
            size: 64,
            color: Colors.white,
          ),
          const Text(
            "Lab-Med for Medical Equibments",
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
          Expanded(child: SizedBox()),
          const Text(
            "برنامج ادارة المبيعات",
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
          Expanded(child: SizedBox()),
          functionaIcons(),
        ],
      ),
    );
  }

  Widget functionaIcons() {
    return Container(
      width: 700,
      padding: EdgeInsets.only(left: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        dataBaseIcon(),
        saveIcon(),
        historyIcon(),
        Icon(
          Icons.settings,
          size: 64,
          color: Colors.white,
        ),
      ]),
    );
  }

  Widget dataBaseIcon() {
    return HeaderIcon(
      icon: const Icon(
        Icons.edit,
        size: 48,
      ),
      tapFunction: openDataBase,
    );
  }

  Widget saveIcon() {
    return HeaderIcon(
      icon: const Icon(
        Icons.check,
        size: 48,
      ),
      tapFunction: save,
    );
  }

  Widget historyIcon() {
    return HeaderIcon(
      icon: const Icon(
        Icons.history,
        size: 48,
      ),
      tapFunction: showHistory,
    );
  }

  void openDataBase() {
    widget.dataBaseCallBack();
  }

  void save() {
    dataBox.clear();
    data["ICT"]?.sort(
      (a, b) => a.name.compareTo(b.name),
    );
    data.forEach((key, value) {
      dataBox.put(key, value);
    });
  }

  void showHistory() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              title: Text("choose customer order number"),
              content: CustomerScreen(),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.grey),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "close",
                      style: TextStyle(fontSize: 32),
                    )),
              ],
            ));
  }
}
