import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_http_2024/block/block.dart';
import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/crud/order_crud.dart';
import 'package:shop_http_2024/model/order_head.dart';
import 'package:shop_http_2024/model/order_row.dart';
import 'package:shop_http_2024/model/order_row_res.dart';

class OrderView extends StatefulWidget {
  OrderView({super.key, required this.orderHead});

  OrderHead orderHead;

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  GetOrderRowRes orderRowRes = GetOrderRowRes.empty('', 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          '${widget.orderHead.OrderNumber} ${dataFormatShort.format(widget.orderHead.OrderData)}',
          style: txt20,
        ),
      ),
      body: BlocBuilder<DataCubit, Keeper>(builder: (context, state) {
        if (widget.orderHead.order_rows.isNotEmpty) {
          orderRowRes = GetOrderRowRes('OK', 200, widget.orderHead.order_rows);
        }
        int y33 = 0;
        Widget central = orderRowRes.order_row_list.isEmpty &&
                orderRowRes.status == 0 &&
                orderRowRes.message.isEmpty
            ? CircularProgressIndicator(
                color: Colors.blue,
              )
            : GetCentralWidget(orderRowRes);

        return Center(child: central);
      }),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.blue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total SUMMA: ${widget.orderHead.totalSumma().toStringAsFixed(2)} \$',
                style: txt20,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/OrderForm', arguments: 2);
              },
              child: Text(
                'к заказам',
                style: txt20,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget GetCentralWidget(GetOrderRowRes orderRowRes) {
    Widget central = Text(
      '${orderRowRes.message} status: ${orderRowRes.status}',
      style: txt15,
    );

    if (orderRowRes.order_row_list.isNotEmpty && orderRowRes.status == 200) {
      central = ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
          thickness: 1,
        ),
        itemCount: orderRowRes.order_row_list.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
              child: Text(
                '${index + 1}',
                style: txt15,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderRowRes.order_row_list[index].product.ProductName,
                  style: txt15,
                ),
              ],
            ),
            trailing: Text(
              '${orderRowRes.order_row_list[index].qty} шт',
              style: txt15,
            ),
            subtitle: Text(
              'всего: ${orderRowRes.order_row_list[index].qty}шт Х ${orderRowRes.order_row_list[index].product.Price} = ${(orderRowRes.order_row_list[index].qty * orderRowRes.order_row_list[index].product.Price).toStringAsFixed(2)}',
              style: txt15,
            ),
          );
        },
      );
    }
    return central;
  }

  @override
  void initState() {
    super.initState();

    if (orderRowRes.order_row_list.isEmpty && orderRowRes.status == 0) {
      OrderCrud.getOrderRowList(
              context.read<DataCubit>().getToken, widget.orderHead.Id)
          .then((value) {
        print(value);
        widget.orderHead.order_rows = value.order_row_list;
        orderRowRes = value;
        if (widget.orderHead.Id > 0) {
          context.read<DataCubit>().OrderHeadResUpd(widget.orderHead);
        }
        setState(() {});
      });
    }
  }
}
