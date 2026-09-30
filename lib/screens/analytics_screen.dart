import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../providers/finance_provider.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FinanceProvider>();
    final expenses = provider.transactions.where((t) => t.type == TransactionType.expense).toList();
    final totalExp = provider.totalExpense;

    final Map<String, double> categorySums = {};
    for (final tx in expenses) {
      categorySums[tx.category] = (categorySums[tx.category] ?? 0.0) + tx.amount;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analyses & Budget'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Taux d’épargne estimé', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: provider.totalIncome > 0
                          ? (provider.netBalance / provider.totalIncome).clamp(0.0, 1.0)
                          : 0.0,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green,
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      provider.totalIncome > 0
                          ? '${((provider.netBalance / provider.totalIncome) * 100).toStringAsFixed(1)}% des revenus conservés'
                          : 'Revenus insuffisants pour calculer le ratio',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Répartition des dépenses',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (categorySums.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('Aucune dépense à analyser'),
                ),
              )
            else
              ...categorySums.entries.map((entry) {
                final percentage = totalExp > 0 ? (entry.value / totalExp) : 0.0;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text(
                            '\$${entry.value.toStringAsFixed(2)} (${(percentage * 100).toStringAsFixed(1)}%)',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: percentage,
                          minHeight: 8,
                          color: Colors.deepPurple,
                          backgroundColor: Colors.deepPurple.withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
