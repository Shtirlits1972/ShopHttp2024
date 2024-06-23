import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/model/get_products_res.dart';
import 'package:shop_http_2024/model/product.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ProductCRUD {
  static Future<getProductRes> getProduct() async {
    List<Product> list = [];

    getProductRes result = getProductRes.empty();

    try {
      var response = await http.get(Uri.https(host, '/api/Products'));

      result.status = response.statusCode;

      if (response.statusCode == 200) {
        var allData = (json.decode(response.body) as List<dynamic>);
        print(allData);
        allData.forEach((dynamic val) {
          Product product = Product.empty();

          product.Id = val['id'];
          product.ProductName = val['productName'];
          product.Price = val['price'];
          product.Foto = val['foto'];

          product.CategoryId = val['categoryId'];
          product.CategoryName = val['category']['categoryName'];

          list.add(product);
        });
        result.products = list;
        result.message = 'OK';

        if (result.products.isEmpty) {
          result.message = 'No Data';
        }

        return result;
      } else {
        print(response.statusCode);
        result.message = 'statusCode ${response.statusCode}';
        return result;
      }
    } on Exception catch (exception) {
      print('exception: $exception');
      result.message = 'exception: $exception';
      return result;
    } catch (error) {
      print('error: $error');
      result.message = 'error: $error';
      return result;
    }
  }
}
