import 'dart:io';

import 'package:shop_http_2024/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class UserCrud {
  static Future<String> register(
      String Email, String Password, String UsersName) async {
    String token = '';

    try {
      var response =
          await http.post(Uri.https(host, '/api/Account/RegisterOutside', {
        'Email': Email,
        'UsersName': UsersName,
        'Password': Password,
        'ConfirmPassword': Password
      }));

      if (response.statusCode == 200) {
        token = response.body;
        print(response.body);
      } else {
        print(response.statusCode);
      }
    } on HttpException catch (http_except) {
      print(http_except);
      int y = 0;
    } on Exception catch (exception) {
      print(exception);
      int y = 0;
    }

    return token;
  }

  static Future<void> logOut() async {
    var response = await http.post(Uri.https(host, '/api/Account/LoginOut'));
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
  }

  static Future<String> autorize(String Email, String Password) async {
    String token = '';

    try {
      var response = await http.post(Uri.https(host,
          '/api/Account/LoginOutside', {'Email': Email, 'Password': Password}));

      if (response.statusCode == 200) {
        token = response.body;
        print(response.body);
      } else {
        print(response.statusCode);
      }
    } on HttpException catch (http_except) {
      print(http_except);
      int y = 0;
    } on Exception catch (exception) {
      print(exception);
      int y = 0;
    }

    return token;
  }
}
