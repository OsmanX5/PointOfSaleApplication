import 'package:flutter/material.dart';
import 'package:pos_labmed/Database/database_item_widget.dart';
import 'package:pos_labmed/Header%20libs/header_icon.dart';
import 'package:pos_labmed/Items_screen_libs/item.dart';
import 'package:pos_labmed/main.dart';

class DataBaseScreen extends StatefulWidget {
  @override
  State<DataBaseScreen> createState() => _DataBaseScreenState();
}

class _DataBaseScreenState extends State<DataBaseScreen> {
  bool savehovering = false;
  bool addhovering = false;
  String dropdownVal = "LAB";
  String dropdownValprice = "ICT";
  TextEditingController newItem = TextEditingController(text: "Item");
  TextEditingController precentage = TextEditingController(text: "5");
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 20, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          controlsHeadr(),
          Row(
            children: categories
                .map((category) => categoryWidgetList(category))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget controlsHeadr() {
    return Container(
      width: 1920,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [addItemWidget(), pricesChangeWidget()],
      ),
    );
  }

  Widget categoryWidgetList(String categoryName) {
    List<Item>? itemList = data[categoryName];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        name(categoryName),
        SizedBox(
            width: 380,
            height: 870,
            child: ListView(
                controller: ScrollController(),
                children: itemsBuilder(itemList!))),
      ],
    );
  }

  Widget name(String name) {
    return Container(
      height: 30,
      width: 380,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  List<Widget> itemsBuilder(List<Item> itemList) {
    List<Widget> result = [];
    itemList.forEach((item) {
      result.add(DatabaseItemWidget(
        item: item,
        refresh: refresh,
      ));
    });
    return result;
  }

  Widget addButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: 60,
      height: 60,
      child: HeaderIcon(
        icon: Icon(
          Icons.send,
          size: 32,
        ),
        tapFunction: add,
      ),
    );
  }

  Widget addItemWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white10,
          //border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      alignment: Alignment.center,
      height: 80,
      width: 620,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // input Item name
          Container(
              width: 300,
              child: TextField(
                controller: newItem,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.black,
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: "Item name",
                ),
              )),

          // drop down Category
          Container(
            width: 200,
            color: Colors.black38,
            child: DropdownButton<String>(
              value: dropdownVal,
              dropdownColor: Colors.grey,
              isExpanded: true,
              items: categories.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                );
              }).toList(),
              onChanged: (x) {
                setState(() {
                  dropdownVal = x!;
                });
              },
            ),
          ),
          addButton(),
        ],
      ),
    );
  }

  void add() {
    if (!alreadyExist(newItem.text, dropdownVal)) {
      setState(() {
        data[dropdownVal]?.add(Item(dropdownVal, newItem.text, {"box": 1}));
        newItem.text = "new Item";
      });
    }
  }

  bool alreadyExist(String name, String category) {
    for (int i = 0; i < data[category]!.length; i++) {
      if (data[category]![i].name == name) {
        return true;
        break;
      }
    }
    return false;
  }

  Widget pricesChangeWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white24,
          //border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.only(left: 20, right: 10),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      alignment: Alignment.center,
      height: 100,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // input price change precentage
            Container(
                width: 50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: precentage,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.black,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: "%",
                  ),
                )),

            // drop down Category
            Container(
              width: 90,
              color: Colors.black38,
              child: DropdownButton<String>(
                value: dropdownValprice,
                dropdownColor: Color.fromARGB(255, 48, 48, 48),
                isExpanded: true,
                items: categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                }).toList(),
                onChanged: (x) {
                  setState(() {
                    dropdownValprice = x!;
                  });
                },
              ),
            ),
            changePriceButton(),
          ],
        ),
      ),
    );
  }

  Widget changePriceButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: 50,
      height: 50,
      child: HeaderIcon(
        icon: Container(
          width: 32,
          height: 32,
          child: Center(
            child: Text(
              "%",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        tapFunction: changePrices,
      ),
    );
  }

  void changePrices2Category(String categoy, double precentage) {
    for (int i = 0; i < data[categoy]!.length; i++) {
      data[categoy]![i].details.forEach((key, value) {
        data[categoy]![i].details[key] = value * (1 + precentage / 100);
      });
    }
    setState(() {});
  }

  void changePrices() {
    changePrices2Category(dropdownValprice, double.parse(precentage.text));
  }

  void refresh() {
    setState(() {});
  }
}
