import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pos_labmed/HotRestart.dart';
import 'package:pos_labmed/Items_screen_libs/specificationScreen.dart';
import 'customer.dart';
import 'invoice_item.dart';
import 'package:pos_labmed/main.dart';
import 'package:pos_labmed/pdf/pdf_creater.dart';

import '../Items_screen_libs/item.dart';

class InvoiceWidget extends StatefulWidget {
  const InvoiceWidget({
    Key? key,
    required this.stream,
  }) : super(key: key);
  final Stream<bool> stream;

  @override
  State<InvoiceWidget> createState() => _InvoiceWidgetState();
}

class _InvoiceWidgetState extends State<InvoiceWidget> {
  final time = DateTime.now();
  bool cash = false;
  bool mBok = false;
  bool check = false;
  bool debt = false;
  bool printhovering = false;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    widget.stream.listen((event) {
      refresh();
    });
  }

  refresh() {
    setState(() {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30, top: 30, bottom: 30),
      width: 588,
      height: 964,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          invoiceHeader(),
          const Text(
            "Item                price X QTY          Total",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          invoiceWidget(),
          Text(
            "Total : " + currentCustomer.total.toStringAsFixed(0),
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          finalPrint(),
        ],
      ),
    );
  }

  Widget invoiceHeader() {
    return Container(
      width: 525,
      height: 280,
      child: Column(children: [
        // Titel
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(
              Icons.biotech,
              size: 48,
              color: Colors.black,
            ),
            Text(
              "Lab-Med for Medical Equibments",
              style: TextStyle(fontSize: 26, color: Colors.black),
            ),
            Icon(
              Icons.biotech,
              size: 48,
              color: Colors.black,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        //Permently invoice

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(const Radius.circular(16)),
                border: Border.all(
                  width: 2,
                  color: Colors.black,
                ),
              ),
              child: Text(
                "$orders",
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const Expanded(
              child: Text(
                "فاتورة مبدئية",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "${time.day}/${time.month}",
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "${time.year}",
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "${time.hour} : ${time.minute}",
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ],
        ),

        // name
        TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.person,
                size: 48,
                color: Colors.black,
              )),
          textDirection: TextDirection.rtl,
          style: const TextStyle(
            fontSize: 28,
            color: Colors.black,
          ),
          onChanged: (txt) {
            currentCustomer.name = txt;
          },
        ),
        // pay methods
        payMethod(),
      ]),
    );
  }

  Widget invoiceWidget() {
    return Container(
        width: 525,
        height: 500,
        child: ListView(
            controller: _scrollController,
            children: invoiceItemsBuilder(currentCustomer.invoiceItems)));
  }

  // a function convert list of items data to list of items widgets
  List<Widget> invoiceItemsBuilder(List<InvoiceItem>? items) {
    int counter = 0;
    List<Widget> itemsWidget = [];
    items?.forEach((item) {
      counter += 1;
      itemsWidget.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.all(const Radius.circular(10))),
          child: InkWell(
            onDoubleTap: () {
              editInvoiceItem(item);
              refresh();
            },
            onLongPress: () {
              deletInvoiceItem(item);
              refresh();
            },
            child: ListTile(
              // Name and company
              leading: Container(
                width: 150,
                height: 65,
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: Text(
                        counter.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        //Name
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        //Company
                        Text(
                          item.details,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              // price x qyantity
              title: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.price.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      "  X  ",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      item.qty.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),

              //total
              trailing: Container(
                width: 90,
                child: Text(
                  item.total.toStringAsFixed(0),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
    return itemsWidget;
  }

  Widget payMethod() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 40,
      child: Row(
        children: [
          const Text("Pay method : ",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),

          // cash
          Checkbox(
              value: cash,
              onChanged: (x) {
                setState(() {
                  cash = !cash;
                });
              }),
          Text("Cash",
              style: TextStyle(
                  fontSize: cash ? 20 : 16,
                  fontWeight: cash ? FontWeight.w900 : FontWeight.w400,
                  color: Colors.black)),
          // mBok
          Checkbox(
              value: mBok,
              onChanged: (x) {
                setState(() {
                  mBok = !mBok;
                });
              }),
          Text("mBok",
              style: TextStyle(
                  fontSize: mBok ? 20 : 16,
                  fontWeight: mBok ? FontWeight.w900 : FontWeight.w400,
                  color: Colors.black)),
          // check
          Checkbox(
              value: check,
              onChanged: (x) {
                setState(() {
                  check = !check;
                });
              }),
          Text("check",
              style: TextStyle(
                  fontSize: check ? 20 : 16,
                  fontWeight: check ? FontWeight.w900 : FontWeight.w400,
                  color: Colors.black)),
          // debt
          Checkbox(
              value: debt,
              onChanged: (x) {
                setState(() {
                  debt = !debt;
                });
              }),
          Text("debt",
              style: TextStyle(
                  fontSize: debt ? 20 : 16,
                  fontWeight: debt ? FontWeight.w900 : FontWeight.w400,
                  color: Colors.black))
        ],
      ),
    );
  }

  Widget finalPrint() {
    return Container(
      width: 200,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Container(
        child: InkWell(
          onTap: () {
            cash ? currentCustomer.payMethod += "  CASH  " : "";
            mBok ? currentCustomer.payMethod += "  mBok  " : "";
            check ? currentCustomer.payMethod += "  Chec  " : "";
            debt ? currentCustomer.payMethod += "  debt  " : "";
            if (currentCustomer.invoiceItems.isNotEmpty) {
              PDFCreator temp = PDFCreator(customer: currentCustomer);
              customerHistory.add(currentCustomer);
              temp.savePDF(temp.generateInvoicePDF());
              orders += 1;
              currentCustomer = new Customer(orderNo: orders);
              ordersHistory.put(currentdate, orders);
              refresh();
            }
          },
          onHover: (hovering) {
            setState(() => printhovering = hovering);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.ease,
            padding: EdgeInsets.all(printhovering ? 10 : 0),
            decoration: BoxDecoration(
                color: printhovering ? Colors.amber[400] : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.black, width: 1)),
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Print",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void deletInvoiceItem(InvoiceItem item) {
    for (int i = 0; i < currentCustomer.invoiceItems.length; i++)
      if ((currentCustomer.invoiceItems[i].name == item.name) &&
          (currentCustomer.invoiceItems[i].details == item.details)) {
        currentCustomer.invoiceItems.removeAt(i);
      }
  }

  void editInvoiceItem(InvoiceItem item) {
    for (int i = 0; i < currentCustomer.invoiceItems.length; i++)
      if ((currentCustomer.invoiceItems[i].name == item.name) &&
          (currentCustomer.invoiceItems[i].details == item.details)) {
        currentCustomer.invoiceItems.removeAt(i);
        showPopScreen(context, item.getDataBaseItem());
      }
  }

  Future<void> showPopScreen(BuildContext, Item) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SpecificationScreen(toSaleItem: Item),
        );
      },
    );
  }
}
