import 'dart:convert';
import 'package:fluter_persistencia/http/webclient.dart';
import 'package:fluter_persistencia/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebclient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.parse(urlTransactions))
        .timeout(Duration(seconds: 5));
    // final Response response = await client.get(Uri.parse(urlTransactions)).timeout(Duration(seconds: 5));
    List<Transaction> transactions = _toTransactions(response);
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(Uri.parse(urlTransactions),
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transactionJson);
    Transaction transact = _toTransaction(response);
    print("transacao $transact");
    return transact;
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> jsonDecodedJson = jsonDecode(response.body);
    final List<Transaction> transactions = [];
    for (Map<String, dynamic> transactionJson in jsonDecodedJson) {
      transactions.add(Transaction.fromJson(transactionJson));
    }
    return transactions;
  }

  Transaction _toTransaction(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }
}
