import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_http_2024/block/block.dart';
import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/crud/order_crud.dart';
import 'package:shop_http_2024/model/get_order_head_res.dart';
import 'package:shop_http_2024/widget/bottom_bar.dart';

class OrderForm extends StatefulWidget {
  OrderForm({super.key, required this.selectedIndex});
  int selectedIndex;
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Заказы'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<DataCubit, Keeper>(builder: (context, state) {
        Widget central =
            context.read<DataCubit>().getOrderHeadRes.message.isEmpty
                ? CircularProgressIndicator(
                    color: Colors.blue,
                  )
                : GetCentralWidget(context.read<DataCubit>().getOrderHeadRes);

        if (context.read<DataCubit>().getOrderHeadRes.isEmpty() &&
            context.read<DataCubit>().getOrderHeadRes.status != 200) {
          OrderCrud.getOrderHeadList(context.read<DataCubit>().getToken)
              .then((value) {
            context.read<DataCubit>().setOrderHeadRes(value);
            setState(() {});
          });
        }
        return Center(child: central);
      }),
      bottomNavigationBar: BottomBar(selectedIndex: widget.selectedIndex),
    );
  }

  Widget GetCentralWidget(GetOrderHeadRes result) {
    Widget central = Text(
      'No Data',
      style: txt15,
    );

    if (result.isEmpty()) {
      if (result.status == 200) {
        central = Text(
          'No Data',
          style: txt15,
        );
      } else {
        central = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No Data'),
            Text(
              result.message,
              style: txt15,
            ),
          ],
        );
      }
    } else {
      central = ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
          thickness: 1,
        ),
        itemCount: result.OrderHeadList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/OrderView',
                  arguments: result.OrderHeadList[index]);
            },
            child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue,
                child: Text(
                  '${index + 1}',
                  style: txt20,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    result.OrderHeadList[index].OrderNumber,
                    style: txt20,
                  ),
                ],
              ),
              trailing: Text(
                dataFormatShort.format(result.OrderHeadList[index].OrderData),
                style: txt15,
              ),
            ),
          );
        },
      );
    }
    return central;
  }
}
