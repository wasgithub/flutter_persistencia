import 'dart:async';

import 'package:fluter_persistencia/components/response_dialog.dart';
import 'package:fluter_persistencia/components/transaction_auth_dialog.dart';
import 'package:fluter_persistencia/http/webclients/transaction_webclient.dart';
import 'package:fluter_persistencia/models/contact.dart';
import 'package:fluter_persistencia/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebclient _webclient = TransactionWebclient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value = double.parse(_valueController.text);
                      final transactionCreated =
                          Transaction(value, widget.contact);
                      print('Transactioncreated $transactionCreated');
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                                _save(transactionCreated, password, context);
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(Transaction transactionCreated, String password,
      BuildContext context) async {
    final Transaction transaction =
        await _webclient.save(transactionCreated, password).catchError((e) {
      print('Deuuuu errooo $e');
      showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog(e.message);
          });
    }, test: (e) => e is HttpException)
    .catchError((e) {
      showDialog(
        context: context,
        builder: (contexDialog) {
          return FailureDialog('timeout submitting the transaction');
        });
    }, test: (e) => e is TimeoutException);

    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contexDialog) {
            return FailureDialog('successfull transaction');
          });
      Navigator.pop(context);
    }
  }
}
