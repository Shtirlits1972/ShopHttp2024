import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/model/get_order_head_res.dart';
import 'package:shop_http_2024/model/order_head.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:shop_http_2024/model/order_row.dart';
import 'package:shop_http_2024/model/order_row_res.dart';
import 'package:shop_http_2024/model/product.dart';

class OrderCrud {
  static Future<GetOrderHeadRes> getOrderHeadList(String token) async {
    GetOrderHeadRes result = GetOrderHeadRes.empty();

    try {
      var response = await http.get(Uri.https(host, '/api/OrderHead'),
          headers: {'Authorization': 'Bearer $token'});

      result.status = response.statusCode;

      if (response.statusCode == 200) {
        var allData = (json.decode(response.body) as List<dynamic>);
        print(allData);

        allData.forEach((dynamic val) {
          OrderHead head = OrderHead.empty();

          head.Id = val['id'];
          head.UserId = val['userId'];
          head.OrderNumber = val['orderNumber'];
          head.OrderData = DateTime.parse(val['orderData']);
          result.OrderHeadList.add(head);
        });
        result.message = 'OK';

        if (result.OrderHeadList.isEmpty) {
          result.message = 'No Data';
        }

        return result;
      } else {
        print(response.statusCode);
        result.message = 'Error';
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

  static Future<GetOrderRowRes> getOrderRowList(
      String token, int orderId) async {
    GetOrderRowRes result = GetOrderRowRes.empty('', 0);

    try {
      var response = await http.get(
          Uri.https(
              host, '/api/OrderDetail', {'OrderHeadId': orderId.toString()}),
          headers: {'Authorization': 'Bearer $token'});
      //   /api/OrderDetail?OrderHeadId=14
      result.status = response.statusCode;
      if (response.statusCode == 200) {
        var allData = (json.decode(response.body) as List<dynamic>);
        print(allData);
        //=======================
        allData.forEach((dynamic val) {
          OrderRow order_row = OrderRow.empty();

          order_row.id = val['id'];
          order_row.qty = val['qty'].toInt();

          Product product = Product.empty();

          product.Id = val['product']['id'];
          product.ProductName = val['product']['productName'];
          product.Price = val['product']['price'];
          product.Foto = val['product']['foto'];

          order_row.product = product;

          result.order_row_list.add(order_row);
        });
        result.message = 'OK';

        if (result.order_row_list.isEmpty) {
          result.message = 'No Data';
        }
        return result;
      } else {
        print(response.statusCode);
        result.message = 'Error';
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

  static Future<OrderHead> OrderCreate(
      String token, List<OrderRow> listRow) async {
    OrderHead head = OrderHead.empty();

    //  https://shop-web11.azurewebsites.net/api/OrderHead/0

    try {
      var response = await http.get(Uri.https(host, '/api/OrderHead/0'),
          headers: {'Authorization': 'Bearer $token'});

      int h2 = 0;
      //   /api/OrderDetail?OrderHeadId=14
      //  result.status = response.statusCode;
      if (response.statusCode == 200) {
        print(response.body);
        int h = 0;
        dynamic val = json.decode(response.body);
        head.Id = val['id'];
        head.UserId = val['userId'];
        head.OrderNumber = val['orderNumber'];
        head.OrderData = DateTime.parse(val['orderData']);
        //=======================

        var body = json.encode({
          "id": 0,
          "userId": head.UserId,
          "orderNumber": head.OrderNumber,
          "orderData": head.OrderData.toIso8601String(),
          "user": {
            "id": head.UserId,
            "email": "",
            "password": "",
            "role": "user",
            "usersName": "",
            "isAppruved": true
          }
        });
        int s151 = 0;
        var responseHead = await http.post(Uri.https(host, '/api/OrderHead/'),
            body: body,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            });
        int h_58 = 0;
        if (responseHead.statusCode == 201) {
          print(responseHead.body);
          dynamic OrderHeadNew = json.decode(responseHead.body);
          print(OrderHeadNew);

          head.Id = OrderHeadNew['id'];
          print(head.Id);
          int g33 = 0;

          for (int i = 0; i < listRow.length; i++) {
            Product product = listRow[i].product;
            var orderDetailBody = json.encode({
              "id": 0,
              "orderId": head.Id.toString(),
              "productId": listRow[i].product.Id,
              "qty": listRow[i].qty,
              "product": null,
              "order": null
            });
            var headers = {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token'
            };
            int h_186 = 0;
            // var requestDetail = http.Request(
            //     'POST', Uri.parse('https://$host/api/OrderDetail/'));

            var responseDetail = await http.post(
                Uri.https(host, '/api/OrderDetail/'),
                encoding: Encoding.getByName('utf-8'),
                body: orderDetailBody,
                headers: headers);

            int a = 0;

            print(responseDetail.body);
            print(responseDetail.statusCode);
            int y207 = 0;

            if (responseDetail.statusCode == 201) {
              dynamic detail = json.decode(responseDetail.body);

              OrderRow orderRow = OrderRow.empty();
              orderRow.id = detail['id'];
              orderRow.qty = detail['qty'];

              orderRow.product = product;

              head.order_rows.add(orderRow);
            }
          }
        }

        return head;
      } else {
        print(response.statusCode);
        head.OrderNumber = 'Error status code ${response.statusCode}';
        return head;
      }
    } on Exception catch (exception) {
      print('exception: $exception');
      return head;
    } catch (error) {
      print('error: $error');
      return head;
    }
  }
}
