import 'package:flutter/material.dart';
import 'package:pos_labmed/Items_screen_libs/catedory.dart';
import 'package:pos_labmed/Items_screen_libs/specificationScreen.dart';
import 'package:pos_labmed/main.dart';

import 'item.dart';

//###########################################################
//#############  items screen to show all items #############
//###########################################################

//build with one column contain 2 raws each one with 3 columns called category
//####Category#####
//    class that get input(category name,number of horizental elemnts,number of Vertical elemnts,Color)

class ItemsWidget extends StatefulWidget {
  const ItemsWidget({Key? key}) : super(key: key);

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  Item toSaleItem = Item("ICT", "choose Item", {"Company": 0});

  callback(item) {
    setState(() {
      toSaleItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    nullSafty();
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 30, top: 20, right: 10, bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                Category(
                  name: "ICT",
                  h: 4,
                  w: 3,
                  color: Color.fromARGB(136, 255, 82, 82),
                  setItemFunction: callback,
                ),
                Category(
                  name: "Containers",
                  w: 3,
                  h: 4,
                  color: Color.fromARGB(120, 50, 170, 220),
                  setItemFunction: callback,
                ),
                SpecificationScreen(toSaleItem: toSaleItem)
              ],
            ),
            Row(
              children: [
                Category(
                    name: "LAB",
                    w: 3,
                    h: 6,
                    color: Color.fromARGB(120, 15, 150, 109),
                    setItemFunction: callback),
                Category(
                    name: "Reagents",
                    w: 3,
                    h: 6,
                    color: Color.fromARGB(120, 233, 124, 0),
                    setItemFunction: callback),
                Category(
                    name: "Devices",
                    w: 3,
                    h: 6,
                    color: Color.fromARGB(120, 112, 112, 220),
                    setItemFunction: callback),
              ],
            )
          ],
        ),
      ),
    );
  }

  void nullSafty() {
    print(data.keys);
    categories.forEach((element) {
      if (!data.containsKey(element)) {
        data[element] = [];
      }
    });
    data.forEach((key, value) {
      print("$key, $value");
      if (data[key]!.isEmpty) {
        data[key] = [
          Item("$key", "new Item", {"comp": 0})
        ];
      }
    });
  }
}
