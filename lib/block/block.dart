//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_http_2024/model/order_head.dart';
import 'package:shop_http_2024/model/order_row.dart';
import 'package:shop_http_2024/model/get_order_head_res.dart';
import 'package:shop_http_2024/model/get_products_res.dart';
import 'package:shop_http_2024/model/product.dart';

class Keeper {
  String token = '';
  List<Product> product_list = [];
  getProductRes productRes = getProductRes.empty();
  GetOrderHeadRes orderHeadRes = GetOrderHeadRes.empty();
  List<OrderRow> CartRowList = [];
  int CartRowQty = 0;
  double summa = 0;
}

class DataCubit extends Cubit<Keeper> {
  //================  CartRowList  ==============
  List<OrderRow> get getCartRowList => state.CartRowList;

  CartRowListClear() {
    state.CartRowList.clear();
    state.CartRowQty = 0;
    state.summa = 0;
  }

  setCartRowList(List<OrderRow> newList) {
    state.CartRowList = newList;
    _RowCartRowListGetQty();
  }

  CartRowListDel(OrderRow row) {
    int index = -1;
    for (int i = 0; i < state.CartRowList.length; i++) {
      if (state.CartRowList[i].product.Id == row.product.Id) {
        state.CartRowList[i].qty--;
        index = i;
        break;
      }
    }
    if (state.CartRowList[index].qty <= 0) {
      CartRowListRemoveByIndex(index);
    }
    _RowCartRowListGetQty();
  }

  CartRowListAdd(OrderRow row) {
    bool flag = false;
    for (int i = 0; i < state.CartRowList.length; i++) {
      if (state.CartRowList[i].product.Id == row.product.Id) {
        state.CartRowList[i].qty++;
        flag = true;
        break;
      }
    }
    if (!flag) {
      state.CartRowList.add(row);
    }
    _RowCartRowListGetQty();
  }

  CartRowListRemoveByIndex(int index) {
    state.CartRowList.removeAt(index);
    _RowCartRowListGetQty();
  }

  CartRowListRemoveDismiss(int productId) {
    int index = -1;
    for (int i = 0; i < state.CartRowList.length; i++) {
      if (state.CartRowList[i].product.Id == productId) {
        state.CartRowList[i].qty--;
        if (state.CartRowList[i].qty == 0) {
          index = i;
        }
        break;
      }
    }
    if (index > -1) {
      state.CartRowList.removeAt(index);
    }
    _RowCartRowListGetQty();
  }

  _RowCartRowListGetQty() {
    int qty = 0;
    double summa_tmp = 0;
    for (int i = 0; i < state.CartRowList.length; i++) {
      qty += state.CartRowList[i].qty;
      summa_tmp +=
          state.CartRowList[i].qty * state.CartRowList[i].product.Price;
    }
    state.CartRowQty = qty;
    state.summa = summa_tmp;
  }

  RowCartRowListRemoveRow(int productId) {
    for (int i = 0; i < state.CartRowList.length; i++) {
      int index = 0;
      bool flag = false;
      if (state.CartRowList[i].product.Id == productId) {
        state.CartRowList[i].qty++;
        break;
      }
    }
    _RowCartRowListGetQty();
  }

  int RowCartRowListQty() {
    return state.CartRowQty;
  }

  double get summa => state.summa;

//  =============  CartRowList  =======================

  GetOrderHeadRes get getOrderHeadRes => state.orderHeadRes;

  setOrderHeadRes(GetOrderHeadRes result) {
    state.orderHeadRes = result;
  }

  OrderHead getOrderHeadById(int Id) {
    OrderHead head = OrderHead.empty();

    for (int i = 0; i < state.orderHeadRes.OrderHeadList.length; i++) {
      if (state.orderHeadRes.OrderHeadList[i].Id == Id) {
        head = state.orderHeadRes.OrderHeadList[i];
        break;
      }
    }

    return head;
  }

  OrderHeadResUpd(OrderHead order_head) {
    for (int i = 0; i < state.orderHeadRes.OrderHeadList.length; i++) {
      if (state.orderHeadRes.OrderHeadList[i].Id == order_head.Id) {
        state.orderHeadRes.OrderHeadList[i] = order_head;
        break;
      }
    }
  }

  getProductRes get getProductRess => state.productRes;

  setProductRes(getProductRes result) {
    state.productRes = result;
  }

  String get getToken => state.token;

  setToken(String newToken) {
    state.token = newToken;
  }

  List<Product> get getProduct => state.product_list;

  setProduct(List<Product> new_product_list) {
    state.product_list = new_product_list;
  }

  DataCubit(super.initState);
}
