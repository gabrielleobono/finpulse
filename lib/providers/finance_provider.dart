import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../repositories/transaction_repository.dart';

class FinanceProvider extends ChangeNotifier {
  final TransactionRepository _repository;
  List<TransactionModel> _transactions = [];
  bool _isLoading = false;
  Locale _locale = const Locale('fr');
  ThemeMode _themeMode = ThemeMode.system;

  FinanceProvider({TransactionRepository? repository})
      : _repository = repository ?? TransactionRepository();

  List<TransactionModel> get transactions => List.unmodifiable(_transactions);
  bool get isLoading => _isLoading;
  Locale get locale => _locale;
  ThemeMode get themeMode => _themeMode;

  double get totalIncome => _repository.calculateTotalIncome(_transactions);
  double get totalExpense => _repository.calculateTotalExpense(_transactions);
  double get netBalance => _repository.calculateBalance(_transactions);

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();
    _transactions = await _repository.loadTransactions();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel tx) async {
    _transactions.insert(0, tx);
    notifyListeners();
    await _repository.saveTransactions(_transactions);
  }

  Future<void> deleteTransaction(String id) async {
    _transactions.removeWhere((t) => t.id == id);
    notifyListeners();
    await _repository.saveTransactions(_transactions);
  }

  void setLocale(Locale newLocale) {
    if (_locale != newLocale) {
      _locale = newLocale;
      notifyListeners();
    }
  }

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
