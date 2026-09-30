import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finpulse/models/transaction.dart';
import 'package:finpulse/widgets/transaction_list_item.dart';

void main() {
  testWidgets('W2. TransactionListItem affiche les données et déclenche la suppression', (tester) async {
    bool deleted = false;
    final tx = TransactionModel(
      id: 'tx-99',
      title: 'Abonnement Gym',
      amount: 45.0,
      date: DateTime(2026, 9, 30),
      category: 'Health',
      type: TransactionType.expense,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TransactionListItem(
            transaction: tx,
            onDelete: () => deleted = true,
          ),
        ),
      ),
    );

    expect(find.text('Abonnement Gym'), findsOneWidget);
    expect(find.text('-\$45.00'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_upward), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline));
    expect(deleted, isTrue);
  });
}
