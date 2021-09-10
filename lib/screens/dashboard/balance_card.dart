import 'package:fluter_persistencia/models/balance.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final Balance balance;

  const BalanceCard({required this.balance});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          balance.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
