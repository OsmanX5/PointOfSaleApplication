import 'package:pos_labmed/Invoice_libs/invoice_item.dart';
import '../Items_screen_libs/item.dart';

class Customer {
  String name = "";
  int orderNo;
  List<InvoiceItem> invoiceItems = [];
  String payMethod = "";
  double get total {
    double sum = 0;
    invoiceItems.forEach((element) {
      sum += element.total;
    });
    return sum;
  }

  List<InvoiceItem> SortItems(List<InvoiceItem> oldList) {
    List<InvoiceItem> temp = new List.empty();
    oldList.forEach((item) {
      if (item.category == "ICT") {
        temp.add(item);
        oldList.remove(item);
      }
    });
    oldList.forEach((item) {
      if (item.category == "LAB") {
        temp.add(item);
        oldList.remove(item);
      }
    });
    oldList.forEach((item) {
      if (item.category == "Containers") {
        temp.add(item);
        oldList.remove(item);
      }
    });
    oldList.forEach((item) {
      if (item.category == "Reagents") {
        temp.add(item);
        oldList.remove(item);
      }
    });
    oldList.forEach((item) {
      if (item.category == "Devices") {
        temp.add(item);
        oldList.remove(item);
      }
    });
    return temp;
  }

  Customer({required this.orderNo});
}
