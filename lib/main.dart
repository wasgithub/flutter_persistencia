
import 'package:fluter_persistencia/screens/dashboard.dart';
import 'package:flutter/material.dart';

import 'components/transaction_auth_dialog.dart';

void main() {
  runApp(BytebankApp());
  // save(Transaction(200, Contact(0, 'Washington', 2000)));
  // findAll().then((transactions) => print('new transactions ${transactions} '));
  // save(Contact(10, 'alexandre', 1000)).then((id) {
  //   findAll().then((contacts) => debugPrint(contacts.toString()));
  // });
}

class BytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          )),
      home: TransactionAuthDialog(),
    );
  }
}
