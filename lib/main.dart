import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos_labmed/Invoice_libs/customer.dart';
import 'package:pos_labmed/home.dart';
import 'package:pos_labmed/Items_screen_libs/item.dart';
import 'package:pos_labmed/pdf/pdf_creater.dart';
import 'package:window_manager/window_manager.dart';
import 'Invoice_libs/invoice_item.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

///

Map<String, List<Item>> data = {};
String currentdate =
    "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}";

StreamController<bool> streamController = StreamController<bool>.broadcast();
int orders = 1;
late Customer currentCustomer;
late Box dataBox;
List<String> categories = ["ICT", "LAB", "Containers", "Reagents", "Devices"];
late Box ordersHistory;
late Box totalMoney;
List<Customer> customerHistory = [];
Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  dataBox = await Hive.openBox("data", path: "C:/labmedData");
  ordersHistory = await Hive.openBox("ordersHistory", path: "C:/labmedData");
  totalMoney = await Hive.openBox("totalMoney", path: "C:/labmedData");
  data = boxDataRead(dataBox);

  if (!ordersHistory.containsKey(currentdate))
    ordersHistory.put(currentdate, 1);
  orders = ordersHistory.get(currentdate);

  currentCustomer = new Customer(orderNo: orders);
  printAllData();
  runApp(MaterialApp(
    theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Colors.black12,
        canvasColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber)),
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));

/*
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    await windowManager.setFullScreen(false);
    // await windowManager.center();
    // await windowManager.show();
    await windowManager.setSkipTaskbar(true);
  });*/
}

//read all data inside a box
Map<String, List<Item>> boxDataRead(Box box) {
  Map<String, List<Item>> data = {};
  box.keys.forEach((key) {
    data[key] = List<Item>.from(box.get(key));
  });

  return data;
}

void printAllData() {
  data.forEach((key, value) {
    print("Key :${key} , value : ${value}");
  });
}
