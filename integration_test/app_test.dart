import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:finpulse/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('FinPulse Pro End-to-End Integration Tests', () {
    testWidgets('IT1. Parcours complet : Création et affichage d’une dépense', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Vérifie l’écran Dashboard initial
      expect(find.text('FinPulse Dashboard'), findsOneWidget);

      // Clic sur le bouton d’ajout de transaction
      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pumpAndSettle();

      // Saisie dans le formulaire
      final titleField = find.byKey(const Key('transaction_title_field'));
      final amountField = find.byKey(const Key('transaction_amount_field'));
      final saveBtn = find.byKey(const Key('save_transaction_button'));

      await tester.enterText(titleField, 'Test Café Intégration');
      await tester.enterText(amountField, '5.50');
      await tester.tap(saveBtn);
      await tester.pumpAndSettle();

      // Vérifie le retour sur le Dashboard et la présence de la transaction
      expect(find.text('Test Café Intégration'), findsOneWidget);
    });

    testWidgets('IT2. Navigation vers les Paramètres et changement de langue', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Clic sur l'onglet Paramètres dans la barre de navigation
      final settingsTab = find.byIcon(Icons.settings_outlined);
      await tester.tap(settingsTab);
      await tester.pumpAndSettle();

      expect(find.text('Paramètres & Accessibilité'), findsOneWidget);
      expect(find.text('Mode Accessibilité'), findsOneWidget);
    });
  });
}
