import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_http_2024/block/block.dart';
import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/crud/order_crud.dart';
import 'package:shop_http_2024/model/order_head.dart';
import 'package:shop_http_2024/model/order_row.dart';

class OrderView extends StatefulWidget {
  OrderView({super.key, required this.orderHead});

  OrderHead orderHead;

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.orderHead.OrderNumber} ${dataFormatShort.format(widget.orderHead.OrderData)}',
          style: txt20,
        ),
      ),
      body: BlocBuilder<DataCubit, Keeper>(builder: (context, state) {
        Widget central = widget.orderHead.order_rows.isEmpty
            ? CircularProgressIndicator(
                color: Colors.blue,
              )
            : GetCentralWidget(widget.orderHead.order_rows);

        if (widget.orderHead.order_rows.isEmpty) {
          OrderCrud.getOrderRowList(
                  context.read<DataCubit>().getToken, widget.orderHead.Id)
              .then((value) {
            if (value.order_row_list.isNotEmpty && value.status == 200) {
              widget.orderHead.order_rows = value.order_row_list;

              if (widget.orderHead.Id > 0) {
                context.read<DataCubit>().OrderHeadResUpd(widget.orderHead);
                setState(() {});
              }
            }
          });
        }
        return Center(child: central);
      }),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.blue),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Total SUMMA: ${widget.orderHead.totalSumma()}',
            style: txt20,
          ),
        ),
      ),
    );
  }

  Widget GetCentralWidget(List<OrderRow> order_row_list) {
    Widget central = Text(
      'No Data',
      style: txt15,
    );
    int y52 = 0;

    if (order_row_list.isNotEmpty) {
      central = ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
          thickness: 1,
        ),
        itemCount: order_row_list.length,
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
                  order_row_list[index].product.ProductName,
                  style: txt15,
                ),
              ],
            ),
            trailing: Text(
              '${order_row_list[index].qty} шт',
              style: txt15,
            ),
            subtitle: Text(
              'всего: ${order_row_list[index].qty}шт Х ${order_row_list[index].product.Price} = ${order_row_list[index].qty * order_row_list[index].product.Price}',
              style: txt15,
            ),
          );
        },
      );
    }
    return central;
  }
}
