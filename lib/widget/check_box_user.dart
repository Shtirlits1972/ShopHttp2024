import 'package:flutter/material.dart';
import 'package:shop_http_2024/constants.dart';

class CheckboxWidget extends StatefulWidget {
  final Function(bool) callback;

  const CheckboxWidget({Key? key, required this.callback}) : super(key: key);

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool _checkbox = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
            value: _checkbox,
            onChanged: (value) {
              widget.callback(value!);
              setState(() => _checkbox = !_checkbox);
            }),
        Text(
          'Remember me',
          style: txt30,
        )
      ],
    );
  }
}
