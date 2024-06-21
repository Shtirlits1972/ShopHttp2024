import 'package:shop_http_2024/model/product.dart';

class getProductRes {
  List<Product> products = [];
  String message = '';
  int status = 0;

  getProductRes(this.products, this.message, this.status);

  getProductRes.empty() {
    this.products = [];
    this.message = '';
    this.status = 0;
  }

  @override
  String toString() {
    return 'products = $products, message = $message, status = $status';
  }

  bool isEmpty() {
    bool isEmpty = true;

    if (products.length > 0) {
      isEmpty = false;
    }
    return isEmpty;
  }
}
