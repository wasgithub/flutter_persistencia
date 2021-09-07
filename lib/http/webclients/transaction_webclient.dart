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
    Transaction transact = Transaction.fromJson(jsonDecode(response.body));
    print("transacao $transact");
    return transact;
  }

  List<Transaction> _toTransactions(Response response) {
  final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Transaction.fromJson(json)).toList();
    // final List<Transaction> transactions = [];
    // for (Map<String, dynamic> transactionJson in jsonDecodedJson) {
    //   transactions.add(Transaction.fromJson(transactionJson));
    // }
  }
}
