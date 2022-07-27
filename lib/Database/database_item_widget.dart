import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:pos_labmed/Database/functional_icon.dart';
import 'package:pos_labmed/Items_screen_libs/item.dart';
import 'package:pos_labmed/main.dart';

class DatabaseItemWidget extends StatefulWidget {
  Item item;
  Item updatedItem = Item("", "", {});
  int index = 0;
  Function refresh;
  DatabaseItemWidget({required this.item, required this.refresh}) {
    updatedItem = item;
    index = data[item.category]!.indexOf(item);
  }

  @override
  State<DatabaseItemWidget> createState() => _DatabaseItemWidgetState();
}

class _DatabaseItemWidgetState extends State<DatabaseItemWidget> {
  List<TextEditingController> namesfields = [];
  List<TextEditingController> pricesfields = [];
  bool nameHover = false;
  bool datachanged = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 380,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: const BorderRadius.all(const Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [name(), position()]),
          companies(),
          actions(),
        ],
      ),
    );
  }

  Widget name() {
    return Container(
      width: 70,
      child: InkWell(
        onHover: (val) {
          setState(() {
            nameHover = val;
          });
        },
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    actionsAlignment: MainAxisAlignment.center,
                    title: Text("delet ${widget.item.name} item"),
                    actions: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            delet();
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Delet",
                            style: TextStyle(fontSize: 32),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.grey),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "close",
                            style: TextStyle(fontSize: 32),
                          )),
                    ],
                  ));
        },
        child: Text(
          widget.item.name,
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 18,
            color: nameHover ? Colors.red : Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget position() {
    return Container(
      width: 70,
      height: 40,
      child: Row(children: [moveUpIcon(), movDownIcon()]),
    );
  }

  Widget moveUpIcon() {
    return FunctionalIcon(
      icon: Icon(Icons.arrow_upward),
      tapFunction: moveUp,
      animate: false,
      size: 32,
    );
  }

  Widget movDownIcon() {
    return FunctionalIcon(
      icon: Icon(Icons.arrow_downward),
      tapFunction: moveDown,
      animate: false,
      size: 32,
    );
  }

  Widget companies() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: companiesList(),
      ),
    );
  }

  List<Widget> companiesList() {
    List<Widget> temp = [];
    widget.item.details.forEach((key, value) {
      temp.add(compani(key, value));
    });

    return temp;
  }

  Widget compani(String name, double price) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [companiField(name, price), priceField(name, price)],
      ),
    );
  }

  Widget companiField(String name, double price) {
    int index = namesfields.length;
    namesfields.add(TextEditingController(text: name));
    return Container(
      width: 90,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(5)),
      child: TextField(
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(border: InputBorder.none),
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        controller: namesfields[index],
        onChanged: (_) {},
      ),
    );
  }

  Widget priceField(String name, double price) {
    int index = pricesfields.length;
    pricesfields.add(TextEditingController(text: price.toStringAsFixed(0)));

    return Container(
      width: 90,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(5)),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(border: InputBorder.none),
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        controller: pricesfields[index],
        onChanged: (_) {},
      ),
    );
  }

  Widget addCompanyIcon() {
    return FunctionalIcon(
      primaryColor: widget.item.details.length < 6
          ? Colors.white
          : Color.fromARGB(255, 73, 73, 73),
      icon: Icon(Icons.add),
      animate: widget.item.details.length < 6,
      tapFunction: () {
        if (widget.item.details.length < 6) {
          setState(() {
            datachanged = true;
            addCompany();
          });
        } else {}
      },
    );
  }

  void addCompany() {
    widget.item.details["new comp ${widget.item.details.length}"] = 0;
  }

  Widget saveCompanyIcon() {
    return FunctionalIcon(
      animate: datachanged,
      primaryColor:
          datachanged ? Colors.white : Color.fromARGB(255, 73, 73, 73),
      icon: Icon(
        Icons.check,
      ),
      tapFunction: () {
        if (datachanged)
          setState(() {
            saveCompany();
          });
        else {}
      },
    );
  }

  void saveCompany() {
    Parser p = new Parser();
    Expression exp;
    double value;
    widget.item.details = {};
    for (int i = 0; i < namesfields.length; i++) {
      exp = p.parse(pricesfields[i].text);
      value = exp.evaluate(EvaluationType.REAL, ContextModel());
      widget.item.details[namesfields[i].text] = value;
    }
  }

  void delet() {
    data[widget.item.category]!.removeAt(widget.index);
    widget.refresh();
  }

  void moveUp() {
    if (widget.index > 0) {
      Item temp;
      temp = data[widget.item.category]![widget.index];
      data[widget.item.category]![widget.index] =
          data[widget.item.category]![widget.index - 1];
      data[widget.item.category]![widget.index - 1] = temp;
      setState(() {
        widget.refresh();
      });
    }
  }

  void moveDown() {
    if (widget.index < data[widget.item.category]!.length - 1) {
      Item temp;
      temp = data[widget.item.category]![widget.index];
      data[widget.item.category]![widget.index] =
          data[widget.item.category]![widget.index + 1];
      data[widget.item.category]![widget.index + 1] = temp;
      setState(() {
        widget.refresh();
      });
    }
  }

  Widget actions() {
    return Container(
      child: SizedBox(
        width: 60,
        child: Column(
          children: [addCompanyIcon(), saveCompanyIcon()],
        ),
      ),
    );
  }
}
