import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/model/category.dart';
import 'package:shop_http_2024/model/get_category_res.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class CategoryCrud {
  static Future<GetCategoryRes> getCategory(String token) async {
    GetCategoryRes result = GetCategoryRes.empty();
    List<Category> list = [];

    try {
      var response = await http.get(Uri.https(host, '/api/Categories'),
          headers: {'Authorization': 'Bearer $token'});

      result.status = response.statusCode;

      if (response.statusCode == 200) {
        var allData = (json.decode(response.body) as List<dynamic>);
        print(allData);
        allData.forEach((dynamic val) {
          Category category = Category.empty();

          category.id = val['id'];
          category.categoryName = val['categoryName'];

          list.add(category);
        });
        result.categoryes = list;
        result.message = 'OK';

        if (result.categoryes.isEmpty) {
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
