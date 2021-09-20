import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptoos/logging_interceptor.dart';

const String urlTransactions = 'http://192.168.0.51:8080/transactions';
// const String urlTransactions = 'http://192.168.6.100:8080/transactions';

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);

