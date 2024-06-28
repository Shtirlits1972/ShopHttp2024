import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_http_2024/block/block.dart';
import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/crud/param_crud.dart';
import 'package:shop_http_2024/crud/user_crud.dart';
import 'package:shop_http_2024/widget/alert.dart';
import 'package:shop_http_2024/widget/check_box_user.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  final String route = '/';
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController loginController = TextEditingController();
    TextEditingController passController = TextEditingController();
    bool isCheckedFrm = false;

    loginController.text = 'petia@mail.ru';
    passController.text = '123';

    return Scaffold(
      body: BlocBuilder<DataCubit, Keeper>(
        builder: (context, state) {
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
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 16,
                        height: 50,
                        child: ElevatedButton(
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
                                ParamCrud.upd('token', token.trim());

                                ParamCrud.upd(
                                    'remember', isCheckedFrm.toString());
                                ParamCrud.upd(
                                    'login', loginController.text.trim());
                                ParamCrud.upd(
                                    'password', passController.text.trim());
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
                  ],
                ),
                CheckboxWidget(callback: (value) => isCheckedFrm = value),
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
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
