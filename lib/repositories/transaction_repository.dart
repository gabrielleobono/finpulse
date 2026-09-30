import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';

class TransactionRepository {
  static const String _storageKey = 'finpulse_transactions_data';
  final SharedPreferences? _prefs;

  TransactionRepository({SharedPreferences? prefs}) : _prefs = prefs;

  List<TransactionModel> getInitialMockData() {
    final now = DateTime.now();
    return [
      TransactionModel(
        id: 'tx-1',
        title: 'Tech Salary',
        amount: 3200.0,
        date: now.subtract(const Duration(days: 1)),
        category: 'Salary',
        type: TransactionType.income,
      ),
      TransactionModel(
        id: 'tx-2',
        title: 'Grocery Store',
        amount: 85.50,
        date: now.subtract(const Duration(days: 2)),
        category: 'Food & Dining',
        type: TransactionType.expense,
      ),
      TransactionModel(
        id: 'tx-3',
        title: 'Metro Pass',
        amount: 45.00,
        date: now.subtract(const Duration(days: 3)),
        category: 'Transport',
        type: TransactionType.expense,
      ),
      TransactionModel(
        id: 'tx-4',
        title: 'Internet Fiber',
        amount: 49.99,
        date: now.subtract(const Duration(days: 4)),
        category: 'Bills & Utilities',
        type: TransactionType.expense,
      ),
    ];
  }

  Future<List<TransactionModel>> loadTransactions() async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    final rawJson = prefs.getString(_storageKey);
    if (rawJson == null) {
      final initial = getInitialMockData();
      await saveTransactions(initial);
      return initial;
    }
    try {
      final List<dynamic> decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded
          .map((item) => TransactionModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return getInitialMockData();
    }
  }

  Future<void> saveTransactions(List<TransactionModel> transactions) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    final encoded = jsonEncode(transactions.map((t) => t.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  double calculateTotalIncome(List<TransactionModel> list) {
    return list
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (acc, t) => acc + t.amount);
  }

  double calculateTotalExpense(List<TransactionModel> list) {
    return list
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (acc, t) => acc + t.amount);
  }

  double calculateBalance(List<TransactionModel> list) {
    return calculateTotalIncome(list) - calculateTotalExpense(list);
  }

  List<TransactionModel> filterByCategory(
      List<TransactionModel> list, String category) {
    if (category.isEmpty || category == 'All') return list;
    return list.where((t) => t.category == category).toList();
  }
}
