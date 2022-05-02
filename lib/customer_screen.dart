import 'package:flutter/material.dart';
import 'package:pos_labmed/custormer_widget.dart';
import 'package:pos_labmed/main.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      child: ListView(children: customerscreenBuilder()),
    );
  }

  List<Widget> customerscreenBuilder() {
    List<Widget> result = [];
    customerHistory.forEach((customer) {
      result.add(CustomerWidget(customer: customer));
    });
    return result;
  }
}
