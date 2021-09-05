import 'package:http/http.dart';

const String urlTransactions = 'http://192.168.0.24:8080/transactions';

void findAll() async {
  final Response response = await get(Uri.parse(urlTransactions));
  print(response.body);
}
