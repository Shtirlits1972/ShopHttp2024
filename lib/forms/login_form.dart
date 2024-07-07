import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_http_2024/block/block.dart';
import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/crud/order_crud.dart';
import 'package:shop_http_2024/crud/param_crud.dart';
import 'package:shop_http_2024/crud/user_crud.dart';
import 'package:shop_http_2024/model/get_order_head_res.dart';
import 'package:shop_http_2024/widget/alert.dart';
import 'package:shop_http_2024/widget/check_box.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);

  final String route = '/';

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Widget centralWidget = Center(child: CircularProgressIndicator());
  @override
  Widget build(BuildContext context) {
    // loginController.text = 'alex1@mail.ru';
    // passController.text = '123';

    int gh44 = 0;

    return Scaffold(
      body: BlocBuilder<DataCubit, Keeper>(
        builder: (context, state) {
          return centralWidget;
          // return getCentralWidget(loginController, passController, context, isCheckedFrm);
        },
      ),
    );
  }

  @override
  void initState() {
    ParamCrud.getParamsBag().then((value) async {
      print(value);

      int y = 0;

      if (!context.read<DataCubit>().getIsRedirect) {
        centralWidget = getCentralWidget(
            value.login, value.password, context, value.remember);
        setState(() {});
        int h3377 = 0;
      } else {
        int h33 = 0;

        if (value.token.isNotEmpty) {
          GetOrderHeadRes orderHeadRes =
              await OrderCrud.getOrderHeadList(value.token);

          if (orderHeadRes.status == 200 && orderHeadRes.message == 'OK') {
            context.read<DataCubit>().setToken(value.token);
            context.read<DataCubit>().setOrderHeadRes(orderHeadRes);

            Navigator.pushNamed(context, '/ProductListForm', arguments: 0);
          } else {
            print('not autorized by token!');

            int h33 = 0;
            centralWidget = getCentralWidget(
                value.login, value.password, context, value.remember);
            setState(() {});
          }
        } else {
          centralWidget = getCentralWidget(
              value.login, value.password, context, value.remember);
          int h77 = 0;
          setState(() {});
        }
      }
    });
    super.initState();
  }

  Center getCentralWidget(String strLogin, String strPassword,
      BuildContext context, bool isCheckedFrm) {
    TextEditingController loginController = TextEditingController();
    loginController.text = strLogin;
    TextEditingController passController = TextEditingController();
    passController.text = strPassword;
    // late bool isCheckedFrm;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: loginController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid mail id as abc@gmail.com'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: passController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter your secure password'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  child: Container(
                    width: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        'Login',
                        style: txt20,
                      ),
                      onPressed: () async {
                        print(
                            'Login: ${loginController.text}, Password: ${passController.text}');
                        context.read<DataCubit>().setToken('');
                        String token = await UserCrud.autorize(
                            loginController.text, passController.text);

                        context.read<DataCubit>().setToken(token);
                        print(token);

                        if (token.trim().isNotEmpty) {
                          //===============================
                          if (isCheckedFrm) {
                            int h = 0;
                            int cnt =
                                await ParamCrud.upd('token', token.trim());

                            await ParamCrud.upd(
                                'remember', isCheckedFrm.toString());
                            await ParamCrud.upd(
                                'login', loginController.text.trim());
                            await ParamCrud.upd(
                                'password', passController.text.trim());

                            String token2 = await ParamCrud.getValue('token');

                            int h2 = 0;
                          } else {
                            ParamCrud.clear();
                          }

                          //===============================
                          Navigator.pushNamed(context, '/ProductListForm',
                              arguments: 0);
                        } else {
                          print('неверный логин и(или) пароль!');

                          showMyDialog(
                              context, 'неверный логин и(или) пароль!');
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          CheckboxWidget(
            callback: (value) => isCheckedFrm = value,
            checkbox: isCheckedFrm,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, '/RegisterForm');
            },
            child: const Text(
              'Register',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
        ],
        //  );
      ),
    );
  }
}
