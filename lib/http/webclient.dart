import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String urlTransactions = 'http://192.168.0.24:8080/transactions';

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

void findAll() async {
  final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.get(Uri.parse(urlTransactions));
  print(response.body);
}
