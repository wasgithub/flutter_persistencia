import 'dart:convert';

import 'package:fluter_persistencia/models/contact.dart';
import 'package:fluter_persistencia/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String urlTransactions = 'http://192.168.5.101:8080/transactions';
// const String urlTransactions = 'http://192.168.6.100:8080/transactions';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("passou aqui");
    print("statusCode: ${data.statusCode}");
    print(data.toString());
    return data;
  }
}

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
);

Future<List<Transaction>> findAll() async {
  final Response response = await client
      .get(Uri.parse(urlTransactions))
      .timeout(Duration(seconds: 5));
  // final Response response = await client.get(Uri.parse(urlTransactions)).timeout(Duration(seconds: 5));
  final List<dynamic> jsonDecodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];

  for (Map<String, dynamic> transactionJson in jsonDecodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transaction = Transaction(
        transactionJson['value'],
        Contact(
          0,
          contactJson['name'],
          contactJson['accountNumber'],
        ));
    transactions.add(transaction);
  }
  return transactions;
}

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber
    }
  };

  final String transactionJson = jsonEncode(transactionMap);

  final Response response = await client.post(Uri.parse(urlTransactions),
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: transactionJson);

  Map<String, dynamic> json = jsonDecode(response.body);

  final Map<String, dynamic> contactJson = json['contact'];
  final Transaction transact = Transaction(
      json['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ));

  return transact;
}
