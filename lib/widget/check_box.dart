import 'package:flutter/material.dart';
import 'package:shop_http_2024/constants.dart';

class CheckboxWidget extends StatefulWidget {
  final Function(bool) callback;

  CheckboxWidget({Key? key, required this.callback, required this.checkbox})
      : super(key: key);
  bool checkbox;
  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
            value: widget.checkbox,
            onChanged: (value) {
              widget.callback(value!);
              setState(() => widget.checkbox = !widget.checkbox);
            }),
        Text(
          'Remember me',
          style: txt30,
        )
      ],
    );
  }
}
