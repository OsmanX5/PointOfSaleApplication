import 'package:flutter/material.dart';
import 'package:pos_labmed/Items_screen_libs/item.dart';
import 'package:pos_labmed/main.dart';

class InvoiceItem extends StatelessWidget {
  String category = "";
  String name = "";
  String details = "";
  double price = 1;
  double qty = 0;
  double get total {
    return price * qty;
  }

  InvoiceItem({
    Key? key,
    required this.category,
    required this.name,
    required this.details,
    required this.price,
    required this.qty,
  }) : super(key: key);

  Item getDataBaseItem() {
    Item theItem = new Item("", "", new Map());
    data[category]?.forEach((dataBaseItem) {
      if (dataBaseItem.name == this.name) {
        theItem = dataBaseItem;
      }
    });
    return theItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
