import 'package:flutter/material.dart';
import 'package:pos_labmed/Invoice_libs/invoice_item.dart';
import 'package:pos_labmed/main.dart';

import 'item.dart';

class ItemWidget extends StatefulWidget {
  Item item;
  Function setItemFunction;
  ItemWidget({Key? key, required this.item, required this.setItemFunction})
      : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 55,
      alignment: Alignment.center,
      child: Column(
        children: [
          // name Box
          Container(
            alignment: Alignment.center,
            width: 110,
            height: 35,
            child: InkWell(
              onTap: () {
                addItem2Invoice();
                streamController.add(true);
              },
              onDoubleTap: () {
                widget.setItemFunction(widget.item);
              },
              onHover: (hovering) {
                setState(() => isHovering = hovering);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
                padding: EdgeInsets.all(isHovering ? 8 : 4),
                decoration: BoxDecoration(
                    color: isHovering
                        ? Colors.amber
                        : Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    border: Border.all(color: Colors.black, width: 1)),
                child: Container(
                  alignment: Alignment.center,
                  width: isHovering ? 120 : 110,
                  child: Text(
                    widget.item.name,
                    style: nameStyle(isHovering ? 16 : 18),
                  ),
                ),
              ),
            ),
          ),
          //price Box
          Container(
            alignment: Alignment.center,
            width: 90,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Text(
              widget.item.details[widget.item.details.keys.first]!
                  .toStringAsFixed(0),
              style: priceStyle(),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle nameStyle(double size) {
    return TextStyle(
      fontFamily: "Roboto",
      fontSize: size,
      color: Colors.black,
      fontWeight: FontWeight.w900,
    );
  }

  TextStyle priceStyle() {
    return TextStyle(
      fontFamily: "Roboto",
      fontSize: 17,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    );
  }

  void addItem2Invoice() {
    int index = -1;
    currentCustomer.invoiceItems.forEach((item) {
      if (item.name == widget.item.name)
        index = currentCustomer.invoiceItems.indexOf(item);
    });
    if (index > -1) {
      currentCustomer.invoiceItems[index].qty += 1;
    } else {
      currentCustomer.invoiceItems.add(InvoiceItem(
        name: widget.item.name,
        details: widget.item.details.keys.first,
        price: widget.item.details[widget.item.details.keys.first] ?? 1,
        qty: 1,
      ));
    }
  }
}
