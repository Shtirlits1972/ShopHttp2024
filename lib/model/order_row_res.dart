import 'package:shop_http_2024/model/order_row.dart';
import 'package:shop_http_2024/model/request_container.dart';

class GetOrderRowRes extends RequestContainer {
  List<OrderRow> order_row_list = [];
  GetOrderRowRes(super.message, super.status, this.order_row_list);

  GetOrderRowRes.empty(super.message, super.status) {
    message = super.message;
    status = super.status;
    order_row_list = [];
  }

  @override
  String toString() {
    return 'message = $message, status = $status, order_row_list = $order_row_list';
  }

  bool isEmpty() {
    bool isEmpty = true;

    if (order_row_list.length > 0) {
      isEmpty = false;
    }
    return isEmpty;
  }
}
