import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finpulse/widgets/stat_card.dart';

void main() {
  testWidgets('W1. StatCard affiche correctement le titre, le montant et la sémantique', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: StatCard(
            title: 'Épargne',
            amount: 1450.50,
            icon: Icons.savings,
            color: Colors.green,
          ),
        ),
      ),
    );

    expect(find.text('Épargne'), findsOneWidget);
    expect(find.text('\$1450.50'), findsOneWidget);
    expect(find.byIcon(Icons.savings), findsOneWidget);
    expect(
      tester.getSemantics(find.byType(StatCard)),
      matchesSemantics(
        label: 'Épargne: 1450.50 dollars',
      ),
    );
  });
}
