import 'package:flutter_test/flutter_test.dart';
import 'package:mybank/models/contact.dart';
import 'package:mybank/models/transaction.dart';

void main (){
  test('Should return the value create a transaction', (){
    final transaction = Transaction('1', 200, Contact(1, 'Teste', null));
    expect(transaction.value, 200);
  });

  test('Should show error when create transaction with value less than zero', (){
    expect(() => Transaction('1', 101, Contact(1, 'Teste', null)), throwsAssertionError);
  });
}