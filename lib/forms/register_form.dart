import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_http_2024/block/block.dart';
import 'package:shop_http_2024/constants.dart';
import 'package:shop_http_2024/crud/user_crud.dart';
import 'package:shop_http_2024/widget/alert.dart';
import 'package:shop_http_2024/widget/check_box.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key}) : super(key: key);

  final String route = 'RegisterForm';

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController loginController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController displayNameController = TextEditingController();
    bool isCheckedFrm = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          appName,
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DataCubit, Keeper>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: displayNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'DisplayName',
                      hintText: 'Enter your display name'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 16,
                      height: 50,
                      child: ElevatedButton(
                        child: Text(
                          'Зарегистрироватся',
                          style: txt20,
                        ),
                        onPressed: () async {
                          print(
                              'Login: ${loginController.text}, Password: ${passController.text}');
                          //=============================
                          String token = await UserCrud.register(
                              loginController.text,
                              passController.text,
                              displayNameController.text);

                          if (token.trim().isNotEmpty) {
                            context.read<DataCubit>().setToken(token);

                            Navigator.pushNamed(context, '/ProductListForm',
                                arguments: 0);
                          } else {
                            print('ошибка регистрации!');

                            showMyDialog(context, 'ошибка регистрации!');
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              CheckboxWidget(
                callback: (value) => isCheckedFrm = value,
                checkbox: true,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: const Text(
                  'Логин',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
