import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_http_2024/block/block.dart';
import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/crud/order_crud.dart';
import 'package:shop_http_2024/model/order_head.dart';
import 'package:shop_http_2024/widget/bottom_bar.dart';
import 'package:shop_http_2024/widget/snack_bar.dart';

class CartForm extends StatefulWidget {
  CartForm({Key? key, required this.selectedIndex}) : super(key: key);
  int selectedIndex;
  @override
  _CartFormState createState() => _CartFormState();
}

class _CartFormState extends State<CartForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Корзинка'),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<DataCubit, Keeper>(builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                    itemCount: context.read<DataCubit>().getCartRowList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue,
                          child: Text(
                            '${index + 1}',
                            style: txt20,
                          ),
                        ),
                        title: Text(
                          context
                              .read<DataCubit>()
                              .getCartRowList[index]
                              .product
                              .ProductName,
                          style: txt20,
                        ),
                        trailing: Text(
                          '${context.read<DataCubit>().getCartRowList[index].qty}  шт',
                          style: txt15,
                        ),
                      );
                    }),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Total: ',
                              style: txt20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              ' ${context.read<DataCubit>().summa.toStringAsFixed(2)} \$',
                              style: txt20,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[200],
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 20, vertical: 10),
                                  textStyle: txt20),
                              onPressed: () async {
                                print('заказать');

                                if (context
                                    .read<DataCubit>()
                                    .getCartRowList
                                    .isEmpty) {
                                  final snack = snackBarOK(
                                      'В корзине нет товаров для заказа');
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snack);
                                } else {
                                  //============================
                                  OrderHead head = await OrderCrud.OrderCreate(
                                      context.read<DataCubit>().getToken,
                                      context.read<DataCubit>().getCartRowList);
                                  print(head);
                                  int g = 0;
                                  //=============================
                                  final snack = snackBarOK(
                                      'Товар успешно заказан № заказа ${head.OrderNumber} сумма ${head.totalSumma().toStringAsFixed(2)} \$');
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snack);
                                  int g2 = 0;

                                  Navigator.pushNamed(context, '/OrderView',
                                      arguments: head);
                                }
                                context.read<DataCubit>().CartRowListClear();
                                setState(() {});
                              },
                              child: Text('заказать'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[200],
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 20, vertical: 10),
                                  textStyle: txt20),
                              onPressed: () {
                                print('очистить');
                                context.read<DataCubit>().CartRowListClear();
                                final snack = snackBarOK('Корзина очищена');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snack);
                                setState(() {});
                              },
                              child: Text('очистить'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomBar(selectedIndex: widget.selectedIndex),
    );
  }
}
