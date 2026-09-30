import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:finpulse/providers/finance_provider.dart';
import 'package:finpulse/screens/dashboard_screen.dart';

void main() {
  testWidgets('W4. DashboardScreen affiche les cartes de résumé et le bouton d’action', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => FinanceProvider(),
        child: const MaterialApp(
          home: DashboardScreen(),
        ),
      ),
    );

    expect(find.text('FinPulse Dashboard'), findsOneWidget);
    expect(find.text('Solde Net'), findsOneWidget);
    expect(find.text('Revenus'), findsOneWidget);
    expect(find.text('Dépenses'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
