import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_http_2024/block/block.dart';
import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/crud/category_crud.dart';
import 'package:shop_http_2024/model/category.dart';
import 'package:shop_http_2024/model/get_category_res.dart';

class CategoryForm extends StatefulWidget {
  CategoryForm({Key? key}) : super(key: key);

  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Text('Categories', style: txt30),
      ),
      body: BlocBuilder<DataCubit, Keeper>(builder: (context, state) {
        Widget central = context
                .read<DataCubit>()
                .getCategoryRes
                .message
                .isEmpty
            ? CircularProgressIndicator(
                color: Colors.blue,
              )
            : Center(
                child:
                    GetCentralWidget(context.read<DataCubit>().getCategoryRes),
              );

        if (context.read<DataCubit>().getCategoryRes.status == 0) {
          CategoryCrud.getCategory(context.read<DataCubit>().getToken).then(
            (value) {
              print(value);

              Category category = Category(0, 'All', true);
              value.categoryes.insert(0, category);

              context.read<DataCubit>().setGetCategoryRes(value);

              central =
                  GetCentralWidget(context.read<DataCubit>().getCategoryRes);

              setState(() {});
            },
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 6,
                child: Center(
                  child: central,
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[200],
                                textStyle: txt20),
                            onPressed: () async {
                              print(context.read<DataCubit>().getCategoryRes);

                              Navigator.pushNamed(context, '/ProductListForm',
                                  arguments: 0);
                            },
                            child: Text('OK'),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   width: 150,
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 5),
                    //     child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.blue[200],
                    //           textStyle: txt20),
                    //       onPressed: () async {
                    //         Navigator.pushNamed(context, '/ProductListForm',
                    //             arguments: 0);
                    //       },
                    //       child: Text('Cancel'),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget GetCentralWidget(GetCategoryRes result) {
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
        itemCount: result.categoryes.length,
        itemBuilder: (context, index) {
          return CheckboxListTile.adaptive(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(
              '${result.categoryes[index].categoryName}',
              style: txt20,
            ),
            onChanged: (value) {
              if (result.categoryes[index].id != 0) {
                setState(() {
                  context
                      .read<DataCubit>()
                      .getCategoryRes
                      .categoryes[index]
                      .isChecked = value!;
                });

                print(result.categoryes[index].id);
              } else {
                for (int i = 0; i < result.categoryes.length; i++) {
                  setState(() {
                    context
                        .read<DataCubit>()
                        .getCategoryRes
                        .categoryes[i]
                        .isChecked = value!;
                  });
                }
              }
            },
            value: result.categoryes[index].isChecked,
          );
        },
      );
    }
    return central;
  }
}
