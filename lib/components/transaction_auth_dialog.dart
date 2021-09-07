import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate',),
      content: TextField(
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 42, letterSpacing: 24),
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
        keyboardType: TextInputType.number ,
      ),
      actions: <Widget>[
        FlatButton(onPressed: () => print('confirm'), child: Text('Confirm')),
        FlatButton(onPressed: () => print('cancel'), child: Text('Cancel')),
      ],
    );
  }
}
