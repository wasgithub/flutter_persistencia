import 'package:firebase_core/firebase_core.dart';
import 'package:fluter_persistencia/models/balance.dart';
import 'package:fluter_persistencia/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() async {
  // Initialize Firebase.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(ChangeNotifierProvider(
    create: (context) => Balance(10),
    child: BytebankApp(),
  ));
  // print(Uuid().v4());
  // save(Transaction(200, Contact(0, 'Washington', 2000)));
  // findAll().then((transactions) => print('new transactions ${transactions} '));
  // save(Contact(10, 'alexandre', 1000)).then((id) {
  //   findAll().then((contacts) => debugPrint(contacts.toString()));
  // });
}

class BytebankApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.purple[900],
          accentColor: Colors.pink[600],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          )),
      home: Dashboard(),
    );
  }
}
