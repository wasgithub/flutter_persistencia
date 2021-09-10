import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fluter_persistencia/models/balance.dart';
import 'package:fluter_persistencia/screens/dashboard/balance_card.dart';
import 'package:fluter_persistencia/screens/contacts_list.dart';
import 'package:fluter_persistencia/screens/transaction_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: BalanceCard(balance: Balance(12.00),)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('images/pp.png'),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FeatureItem(
                    name: 'Transferencia',
                    icon: Icons.monetization_on,
                    onClick: () => _showContactsList(context),
                  ),
                  _FeatureItem(
                    name: 'Transaction Feed',
                    icon: Icons.description,
                    onClick: () => _showTransactionsList(context),
                  ),
                  _FeatureItem(
                    name: 'Scrooll lateral..',
                    icon: Icons.monetization_on,
                    onClick: () => print(
                        'scroll lateral utilizando SingleChildScrollView'),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  void _showContactsList(context) {
    // FirebaseCrashlytics.instance.crash();
    
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContactsList(),
    ));
  }

  void _showTransactionsList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ));
  }
}

class _FeatureItem extends StatelessWidget {
  final String? name;
  final IconData? icon;
  final Function onClick;

  const _FeatureItem({this.name, this.icon, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 32,
                ),
                Text(
                  name ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
