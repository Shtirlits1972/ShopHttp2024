import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_http_2024/block/block.dart';
import 'package:shop_http_2024/forms/cart_form.dart';
import 'package:shop_http_2024/forms/category_form.dart';
import 'package:shop_http_2024/forms/login_form.dart';
import 'package:shop_http_2024/forms/order_head_form.dart';
import 'package:shop_http_2024/forms/order_view.dart';
import 'package:shop_http_2024/forms/product_list_form.dart';
import 'package:shop_http_2024/forms/register_form.dart';
import 'package:shop_http_2024/model/order_head.dart';

class AppRouter {
  final DataCubit cubit = DataCubit(Keeper());
  int selectIndex = 0;

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        const bool isRedirect = false;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: LoginForm(),
          ),
        );

      case '/RegisterForm':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: RegisterForm(),
          ),
        );

      case '/ProductListForm':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: ProductListForm(
              selectedIndex: 0,
            ),
          ),
        );

      case '/CartForm':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: CartForm(
              selectedIndex: 1,
            ),
          ),
        );
      //
      case '/OrderForm':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: OrderForm(
              selectedIndex: 2,
            ),
          ),
        );

      case '/OrderView':
        final OrderHead head = routeSettings.arguments as OrderHead;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: OrderView(
              orderHead: head,
            ),
          ),
        );
//

      case '/CategoryForm':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: CategoryForm(),
          ),
        );

      default:
        const bool isRedirect = true;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: LoginForm(),
          ),
        );
    }
  }
}
