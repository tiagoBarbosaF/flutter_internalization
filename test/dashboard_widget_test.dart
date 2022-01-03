import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mybank/screens/contact_form.dart';

void main() {
  testWidgets('Should display the main title when the Dashboard  is opened',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ContactForm()));
    final newContact = find.byType(Text);
    expect(newContact, findsWidgets);
  });
}
