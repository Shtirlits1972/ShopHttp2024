import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_http_2024/block/block.dart';
import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/model/get_products_res.dart';
import 'package:shop_http_2024/crud/product_crud.dart';
import 'package:shop_http_2024/model/order_row.dart';
import 'package:shop_http_2024/widget/bottom_bar.dart';

class ProductListForm extends StatefulWidget {
  ProductListForm({Key? key, required this.selectedIndex}) : super(key: key);

  int selectedIndex;

  @override
  _ProductListFormState createState() => _ProductListFormState();
}

class _ProductListFormState extends State<ProductListForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'товары',
          style: txt20,
        ),
        // leading: IconButton(
        //   onPressed: () {
        //     print('filter category');
        //   },
        //   icon: const Icon(Icons.filter_alt_outlined),
        // ),
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () {
        //       print('filter category');
        //     },
        //     icon: const Icon(Icons.filter_alt_outlined),
        //     tooltip: 'Filters',
        //   ),
        //   IconButton(
        //     onPressed: () {
        //       print('refresh product');
        //     },
        //     icon: const Icon(Icons.refresh_outlined),
        //     tooltip: 'Refresh',
        //   )
        // ],
      ),
      body: BlocBuilder<DataCubit, Keeper>(builder: (context, state) {
        Widget central =
            context.read<DataCubit>().getProductRess.message.isEmpty
                ? CircularProgressIndicator(
                    color: Colors.blue,
                  )
                : GetCentralWidget(context.read<DataCubit>().getProductRess);

        if (context.read<DataCubit>().getProductRess.isEmpty() &&
            context.read<DataCubit>().getProductRess.status != 200) {
          ProductCRUD.getProduct().then((value) {
            context.read<DataCubit>().setProductRes(value);
            setState(() {});
          });
        }

        return Center(child: central);
      }),
      bottomNavigationBar: BottomBar(selectedIndex: widget.selectedIndex),
    );
  }

  Widget GetCentralWidget(getProductRes result) {
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
        itemCount: result.products.length,
        itemBuilder: (context, index) {
          Widget fotoWidget = Image.asset("assets/images/NoFoto.jpg");

          if (result.products[index].Foto.trim().isNotEmpty &&
              result.products[index].Foto.trim() != 'X') {
            fotoWidget = Image.network(
                'https://$host/images/product/${result.products[index].Id}/${result.products[index].Foto}',
                width: MediaQuery.of(context).size.width - 10,
                fit: BoxFit.fill);
          }

          return ExpansionTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: Text(
                '${index + 1}',
                style: txt20,
              ),
            ),
            title: Text(
              softWrap: true,
              result.products[index].ProductName,
              style: txt20,
            ),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  result.products[index].Price.toStringAsFixed(2),
                  style: txt20,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        OrderRow row = OrderRow(0, result.products[index], 1);
                        context.read<DataCubit>().CartRowListAdd(row);
                        print(
                            'товар ${result.products[index].ProductName} добавлен в корзину');
                        print(context.read<DataCubit>().getCartRowList);
                        setState(() {});
                      },
                      child: Text(
                        '+',
                        style: txt20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Text(
              result.products[index].CategoryName,
              style: txt15,
            ),
            children: [
              fotoWidget,
            ],
          );
        },
      );
    }
    return central;
  }
}
