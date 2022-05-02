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

  Customer({required this.orderNo});
}
