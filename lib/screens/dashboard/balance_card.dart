import 'package:fluter_persistencia/models/balance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalanceCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer<Balance>(builder: (context, valor, child) {
        return Text(
          valor.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        );
      }),
    ));
  }
}
