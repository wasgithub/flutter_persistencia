import 'package:fluter_persistencia/models/contact.dart';
import 'package:fluter_persistencia/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return the value when create a transaction', () {
    final transaction = Transaction(
      '1',
      2000,
      Contact(1, 'was', 1000),
    );
    expect(transaction.value, 2000);
  });
}
