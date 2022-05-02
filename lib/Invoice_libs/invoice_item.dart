import 'package:flutter/material.dart';

class InvoiceItem extends StatelessWidget {
  String name = "";

  String details = "";

  double price = 1;

  double qty = 0;
  double get total {
    return price * qty;
  }

  InvoiceItem({
    Key? key,
    required this.name,
    required this.details,
    required this.price,
    required this.qty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
