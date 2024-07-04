import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_http_2024/block/block.dart';
import 'package:shop_http_2024/crud/param_crud.dart';
import 'package:shop_http_2024/crud/user_crud.dart';
import 'package:shop_http_2024/model/get_order_head_res.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
    required int selectedIndex,
  })  : _selectedIndex = selectedIndex,
        super(key: key);

  final int _selectedIndex;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<DataCubit, Keeper>(
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // Fixed
            backgroundColor: Colors.blue,
            //   getBackground(_selectedIndex), // <-- This works for fixed
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Products',
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Badge(
                  isLabelVisible:
                      context.read<DataCubit>().getCartRowList.isNotEmpty,
                  offset: Offset(7, -7),
                  label: Text(
                    '${context.read<DataCubit>().RowCartRowListQty()}',
                    style: TextStyle(fontSize: 12),
                  ),
                  child: Icon(Icons.shopping_cart_outlined),
                ),
                label: 'Card',
                backgroundColor: Colors.yellow,

                // icon:
                //  context.read<DataCubit>().getCartRowList.isEmpty == true
                //     ? Icon(Icons.shopping_cart)
                //     : Icon(Icons.add_shopping_cart_rounded),
                // label: 'Card',
                // backgroundColor: Colors.yellow,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'OrdersForm',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.door_front_door),
                label: 'LogOut',
                backgroundColor: Colors.blueGrey,
              ),
            ],
            currentIndex: widget._selectedIndex,
            onTap: (value) {
              print(value);
              if (value == 0) {
                Navigator.pushNamed(context, '/ProductListForm',
                    arguments: value);
              } else if (value == 1) {
                Navigator.pushNamed(context, '/CartForm', arguments: value);
              } else if (value == 2) {
                Navigator.pushNamed(context, '/OrderForm', arguments: value);
              } else if (value == 3) {
                UserCrud.logOut();
                context.read<DataCubit>().setToken('');
                GetOrderHeadRes headRes = GetOrderHeadRes.empty();
                context.read<DataCubit>().setOrderHeadRes(headRes);
                context.read<DataCubit>().setIsRedirect(false);
                ParamCrud.upd('token', '');
                Navigator.pushNamed(context, '/', arguments: false);
              }
            },
          );
        },
      ),
    );
  }

  Color? getBackground(int selectedIndex) {
    Color? _color = Colors.green[200];

    if (selectedIndex == 1) {
      _color = Colors.cyan[100];
    } else if (selectedIndex == 2) {
      _color = Colors.pink[100];
    }

    return _color;
  }
}
