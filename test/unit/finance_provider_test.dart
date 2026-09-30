import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finpulse/models/transaction.dart';
import 'package:finpulse/providers/finance_provider.dart';

void main() {
  group('FinanceProvider State Management Tests', () {
    test('11. addTransaction ajoute en début de liste et met à jour les flux', () async {
      final provider = FinanceProvider();
      final newTx = TransactionModel(
        id: 'manual-1',
        title: 'Consulting',
        amount: 1200.0,
        date: DateTime.now(),
        category: 'Salary',
        type: TransactionType.income,
      );

      await provider.addTransaction(newTx);

      expect(provider.transactions.first.id, equals('manual-1'));
      expect(provider.totalIncome, greaterThanOrEqualTo(1200.0));
    });

    test('12. Changement de langue et mode thème notifient les listeners', () {
      final provider = FinanceProvider();
      bool listenerNotified = false;
      provider.addListener(() => listenerNotified = true);

      provider.setLocale(const Locale('en'));
      expect(provider.locale.languageCode, 'en');
      expect(listenerNotified, isTrue);

      listenerNotified = false;
      provider.toggleTheme(true);
      expect(provider.themeMode, ThemeMode.dark);
      expect(listenerNotified, isTrue);
    });
  });
}
