import 'package:shop_http_2024/model/order_head.dart';

class GetOrderHeadRes {
  List<OrderHead> OrderHeadList = [];

  String message = '';
  int status = 0;

  GetOrderHeadRes(this.OrderHeadList, this.message, this.status);

  GetOrderHeadRes.empty() {
    this.OrderHeadList = [];
    this.message = '';
    this.status = 0;
  }

  @override
  String toString() {
    return 'OrderHeadList = $OrderHeadList, message = $message, status = $status';
  }

  bool isEmpty() {
    bool isEmpty = true;

    if (OrderHeadList.length > 0) {
      isEmpty = false;
    }
    return isEmpty;
  }
}
