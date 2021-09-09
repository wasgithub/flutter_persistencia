import 'dart:convert';
import 'package:fluter_persistencia/http/webclient.dart';
import 'package:fluter_persistencia/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebclient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(Uri.parse(urlTransactions));
    // final Response response = await client.get(Uri.parse(urlTransactions)).timeout(Duration(seconds: 5));
    List<Transaction> transactions = _toTransactions(response);
    return transactions;
  }

  save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());
    await Future.delayed(Duration(seconds: 2));

    final Response response = await client.post(Uri.parse(urlTransactions),
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transactionJson);

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String? _getMessage(int statusCode) {
    if(_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'Unkown error';

  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
    // final List<Transaction> transactions = [];
    // for (Map<String, dynamic> transactionJson in jsonDecodedJson) {
    //   transactions.add(Transaction.fromJson(transactionJson));
    // }
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'the was an error submitting transaction',
    401: 'authentication failed', 
    409: 'transction always exists', 

  };
}

class HttpException implements Exception {
  final String? message;

  HttpException(this.message);
}
