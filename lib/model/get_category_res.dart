import 'package:shop_http_2024/model/category.dart';

class GetCategoryRes {
  List<Category> categoryes = [];
  String message = '';
  int status = 0;

  GetCategoryRes(this.categoryes, this.message, this.status);

  GetCategoryRes.empty() {
    this.categoryes = [];
    this.message = '';
    this.status = 0;
  }

  @override
  String toString() {
    return 'products = $categoryes, message = $message, status = $status';
  }

  bool isEmpty() {
    bool isEmpty = true;

    if (categoryes.length > 0) {
      isEmpty = false;
    }
    return isEmpty;
  }
}
