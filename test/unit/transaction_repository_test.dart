import 'package:flutter_test/flutter_test.dart';
import 'package:finpulse/models/transaction.dart';
import 'package:finpulse/repositories/transaction_repository.dart';

void main() {
  group('TransactionRepository Logic & Calculation Tests', () {
    late TransactionRepository repository;
    final now = DateTime.now();

    final mockList = [
      TransactionModel(
        id: '1',
        title: 'Salary',
        amount: 3000.0,
        date: now,
        category: 'Salary',
        type: TransactionType.income,
      ),
      TransactionModel(
        id: '2',
        title: 'Bonus',
        amount: 500.0,
        date: now,
        category: 'Salary',
        type: TransactionType.income,
      ),
      TransactionModel(
        id: '3',
        title: 'Rent',
        amount: 800.0,
        date: now,
        category: 'Bills',
        type: TransactionType.expense,
      ),
      TransactionModel(
        id: '4',
        title: 'Food',
        amount: 200.0,
        date: now,
        category: 'Food & Dining',
        type: TransactionType.expense,
      ),
    ];

    setUp(() {
      repository = TransactionRepository();
    });

    test('6. Calcule correctement le total des revenus', () {
      final income = repository.calculateTotalIncome(mockList);
      expect(income, equals(3500.0));
    });

    test('7. Calcule correctement le total des dépenses', () {
      final expense = repository.calculateTotalExpense(mockList);
      expect(expense, equals(1000.0));
    });

    test('8. Calcule correctement le solde net restant', () {
      final balance = repository.calculateBalance(mockList);
      expect(balance, equals(2500.0));
    });

    test('9. Filtre avec succès les transactions par catégorie spécifique', () {
      final salaryTransactions = repository.filterByCategory(mockList, 'Salary');
      expect(salaryTransactions.length, equals(2));
      expect(salaryTransactions.every((t) => t.category == 'Salary'), isTrue);
    });

    test('10. Renvoie la liste complète si le filtre catégorie est "All"', () {
      final all = repository.filterByCategory(mockList, 'All');
      expect(all.length, equals(4));
    });
  });
}
