import 'package:shop_http_2024/model/product.dart';

class OrderRow {
  int id = 0;
  Product product = Product.empty();
  int qty = 0;

  OrderRow(this.id, this.product, this.qty);

  OrderRow.empty() {
    this.id = 0;
    this.product = Product.empty();
    this.qty = 0;
  }

  double summa() {
    return product.Price * qty;
  }

  @override
  String toString() {
    return 'id = $id, product = $product, qty = $qty';
  }
}
