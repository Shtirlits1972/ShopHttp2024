import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/model/order_row.dart';

class OrderHead {
  int Id = 0;
  int UserId = 0;
  String OrderNumber = '';
  DateTime OrderData = DateTime(2000, 1, 1, 0, 0);

  List<OrderRow> order_rows = [];

  OrderHead(
      this.Id, this.UserId, this.OrderNumber, this.OrderData, this.order_rows);

  OrderHead.empty() {
    this.Id = 0;
    this.UserId = 0;
    this.OrderNumber = '';
    this.OrderData = DateTime(2000, 1, 1, 0, 0);
    this.order_rows = [];
  }

  double totalSumma() {
    double total = 0;

    for (int i = 0; i < order_rows.length; i++) {
      total += order_rows[i].qty * order_rows[i].product.Price;
    }

    return total;
  }

  @override
  String toString() {
    return 'Id = $Id, UserId = $UserId, OrderNumber = $OrderNumber, OrderData = ${dataFormatShort.format(OrderData)}, order_rows = $order_rows';
  }
}
