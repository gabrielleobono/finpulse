import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:finpulse/providers/finance_provider.dart';
import 'package:finpulse/screens/add_transaction_screen.dart';

void main() {
  testWidgets('W3. AddTransactionScreen valide les champs obligatoires avant soumission', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => FinanceProvider(),
        child: const MaterialApp(
          home: AddTransactionScreen(),
        ),
      ),
    );

    expect(find.text('Nouvelle Transaction'), findsOneWidget);

    // Tentative de soumission sans saisir de champs
    await tester.tap(find.byKey(const Key('save_transaction_button')));
    await tester.pump();

    expect(find.text('Veuillez saisir un titre'), findsOneWidget);
    expect(find.text('Veuillez indiquer un montant'), findsOneWidget);
  });
}
