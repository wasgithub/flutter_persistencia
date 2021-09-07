import 'dart:convert';

import 'package:fluter_persistencia/models/contact.dart';
import 'package:fluter_persistencia/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

// const String urlTransactions = 'http://192.168.5.101:8080/transactions';
const String urlTransactions = 'http://192.168.6.100:8080/transactions';

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

Future<List<Transaction>> findAll() async {
  final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.get(Uri.parse(urlTransactions)).timeout(Duration(seconds: 5));
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
