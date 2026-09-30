import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../providers/finance_provider.dart';
import '../widgets/transaction_list_item.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedFilter = 'All';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FinanceProvider>();
    final allList = provider.transactions;

    final filtered = allList.where((tx) {
      final matchesQuery = tx.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          tx.category.toLowerCase().contains(_searchQuery.toLowerCase());
      if (!matchesQuery) return false;
      if (_selectedFilter == 'Income') return tx.type == TransactionType.income;
      if (_selectedFilter == 'Expense') return tx.type == TransactionType.expense;
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des Transactions'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Rechercher un libellé ou catégorie...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                isDense: true,
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: ['All', 'Income', 'Expense'].map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(filter == 'All' ? 'Tous' : (filter == 'Income' ? 'Revenus' : 'Dépenses')),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedFilter = filter),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('Aucune transaction trouvée'))
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final tx = filtered[index];
                      return TransactionListItem(
                        transaction: tx,
                        onDelete: () => provider.deleteTransaction(tx.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
