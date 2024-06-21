import 'package:flutter/material.dart';

Future<void> showMyDialog(BuildContext context, String txtAlert) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Внимание!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(txtAlert),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
