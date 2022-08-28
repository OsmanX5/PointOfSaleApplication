import 'package:flutter/material.dart';
import 'package:pos_labmed/Invoice_libs/invoice_item.dart';
import 'package:pos_labmed/Items_screen_libs/item.dart';
import 'package:pos_labmed/main.dart';

class SpecificationScreen extends StatefulWidget {
  Item toSaleItem;
  String selected_key = "";
  double currentPrice = 0;
  double qty = 0;
  double total = 0;

  SpecificationScreen({required this.toSaleItem}) {
    selected_key = toSaleItem.details.keys.first;
    currentPrice = toSaleItem.details[selected_key] ?? 1;
  }

  @override
  State<SpecificationScreen> createState() => _SpecificationScreenState();
}

class _SpecificationScreenState extends State<SpecificationScreen> {
  final _controller = TextEditingController();
  bool addHover = false;
  @override
  Widget build(BuildContext context) {
    _controller.text = widget.qty.toStringAsFixed(0);
    if (widget.qty < 0) widget.qty = 0;
    widget.total = widget.qty * widget.currentPrice;
    return Container(
      width: 376,
      height: 356,
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.black,
          border: Border.all(color: Colors.white, width: 3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //############## The Item name##############
          Text(
            widget.toSaleItem.name,
            style: TextStyle(color: Colors.white, fontSize: 36),
          ),

          //############## List of companies ########
          Wrap(
            children: companiesWidget(widget.toSaleItem),
          ),
          //######## Quantity ##############
          Quantity(),
          //#######  Total price #########
          totalPrice(),
          // ###### Add to invoice #######
          addToInvoice(),
        ],
      ),
    );
  }

  //###### Companies List Widget ############
  List<Widget> companiesWidget(Item item) {
    List<Widget> temp = [];
    item.details.forEach((key, value) {
      temp.add(
        Container(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.selected_key = key;
                    widget.currentPrice = value;
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  color:
                      widget.selected_key == key ? Colors.amber : Colors.white,
                  width: 100,
                  height: 32,
                  child: Center(
                      child: Text(
                    key,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
              Text(
                value.toStringAsFixed(0),
                style: TextStyle(
                  color:
                      widget.selected_key == key ? Colors.amber : Colors.white,
                ),
              )
            ],
          ),
        ),
      );
    });
    return temp;
  }

  //###### Quantiti Widget ############
  Widget Quantity() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      height: 60,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QuantityIcon(Icons.arrow_back_ios_sharp, -20, 50),
            QuantityIcon(Icons.arrow_back_ios_sharp, -5, 40),
            QuantityIcon(Icons.arrow_back_ios_sharp, -1, 30),
            QuantityNumber(),
            QuantityIcon(Icons.arrow_forward_ios_sharp, 1, 30),
            QuantityIcon(Icons.arrow_forward_ios_sharp, 5, 40),
            QuantityIcon(Icons.arrow_forward_ios_sharp, 20, 50),
          ],
        ),
      ),
    );
  }

  Widget QuantityIcon(IconData icon, int value, double size) {
    return InkWell(
        onTap: () {
          setState(() {
            widget.qty += value;
          });
        },
        child: Icon(
          icon,
          color: Colors.white,
          size: size,
        ));
  }

  Widget QuantityNumber() {
    return Container(
      width: 100,
      height: 40,
      color: Colors.white,
      child: Center(
          child: TextField(
        controller: _controller,
        autofocus: true,
        onChanged: (value) {
          setState(() {
            widget.qty = double.parse(value);
          });
        },
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        decoration: InputDecoration(),
      )),
    );
  }

  Widget totalPrice() {
    return Text(
      widget.total.toStringAsFixed(0),
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
    );
  }

  Widget addToInvoice() {
    return Container(
      alignment: Alignment.center,
      width: 180,
      height: 50,
      child: InkWell(
        onTap: () {
          addItem2Invoice();
          streamController.add(true);
          Navigator.pop(context);
        },
        onHover: (hovering) {
          setState(() => addHover = hovering);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
          padding: EdgeInsets.all(addHover ? 8 : 4),
          decoration: BoxDecoration(
              color: addHover ? Colors.amber : Color.fromARGB(255, 56, 56, 56),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                  color: Color.fromARGB(255, 255, 255, 255), width: 1)),
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              "+",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addItem2Invoice() {
    int index = -1;
    currentCustomer.invoiceItems.forEach((item) {
      if (item.name == widget.toSaleItem.name &&
          item.details == widget.selected_key)
        index = currentCustomer.invoiceItems.indexOf(item);
    });
    if (index > -1) {
      currentCustomer.invoiceItems[index].qty += widget.qty;
    } else {
      currentCustomer.invoiceItems.add(InvoiceItem(
        category: widget.toSaleItem.category,
        name: widget.toSaleItem.name,
        details: widget.selected_key,
        price: widget.currentPrice,
        qty: widget.qty == 0 ? 1 : widget.qty,
      ));
    }
  }
}
