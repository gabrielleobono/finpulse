import 'package:flutter_test/flutter_test.dart';
import 'package:finpulse/models/transaction.dart';

void main() {
  group('TransactionModel Unit Tests', () {
    final testDate = DateTime(2026, 9, 30, 12, 0);

    test('1. Crée une instance valide avec les propriétés requises', () {
      final tx = TransactionModel(
        id: 'tx-100',
        title: 'Freelance Design',
        amount: 850.0,
        date: testDate,
        category: 'Salary',
        type: TransactionType.income,
      );

      expect(tx.id, 'tx-100');
      expect(tx.title, 'Freelance Design');
      expect(tx.amount, 850.0);
      expect(tx.type, TransactionType.income);
    });

    test('2. Sérialisation correcte en JSON (toJson)', () {
      final tx = TransactionModel(
        id: 'tx-101',
        title: 'Internet',
        amount: 49.99,
        date: testDate,
        category: 'Bills',
        type: TransactionType.expense,
      );

      final json = tx.toJson();
      expect(json['id'], 'tx-101');
      expect(json['amount'], 49.99);
      expect(json['type'], 'expense');
      expect(json['date'], testDate.toIso8601String());
    });

    test('3. Désérialisation correcte depuis JSON (fromJson)', () {
      final json = {
        'id': 'tx-102',
        'title': 'Restaurant',
        'amount': 35.5,
        'date': testDate.toIso8601String(),
        'category': 'Food & Dining',
        'type': 'expense',
      };

      final tx = TransactionModel.fromJson(json);
      expect(tx.id, 'tx-102');
      expect(tx.title, 'Restaurant');
      expect(tx.amount, 35.5);
      expect(tx.type, TransactionType.expense);
    });

    test('4. Fonctionnement de copyWith pour mise à jour immuable', () {
      final tx = TransactionModel(
        id: 'tx-103',
        title: 'Transport',
        amount: 15.0,
        date: testDate,
        category: 'Transport',
        type: TransactionType.expense,
      );

      final updated = tx.copyWith(amount: 20.0, title: 'Taxi Uber');
      expect(updated.id, 'tx-103');
      expect(updated.amount, 20.0);
      expect(updated.title, 'Taxi Uber');
      expect(updated.category, 'Transport');
    });

    test('5. Égalité structurelle (operator == et hashCode)', () {
      final tx1 = TransactionModel(
        id: 'tx-1',
        title: 'Coffee',
        amount: 3.5,
        date: testDate,
        category: 'Food',
        type: TransactionType.expense,
      );

      final tx2 = TransactionModel(
        id: 'tx-1',
        title: 'Coffee',
        amount: 3.5,
        date: testDate,
        category: 'Food',
        type: TransactionType.expense,
      );

      expect(tx1, equals(tx2));
      expect(tx1.hashCode, equals(tx2.hashCode));
    });
  });
}
