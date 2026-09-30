import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';
import '../widgets/stat_card.dart';
import '../widgets/transaction_list_item.dart';
import 'add_transaction_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FinanceProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('FinPulse Dashboard'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Actualiser',
            onPressed: () => context.read<FinanceProvider>().init(),
          ),
        ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => context.read<FinanceProvider>().init(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                cacheExtent: 500,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        StatCard(
                          title: 'Solde Net',
                          amount: provider.netBalance,
                          icon: Icons.account_balance_wallet,
                          color: provider.netBalance >= 0 ? Colors.blue : Colors.red,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                title: 'Revenus',
                                amount: provider.totalIncome,
                                icon: Icons.trending_up,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: StatCard(
                                title: 'Dépenses',
                                amount: provider.totalExpense,
                                icon: Icons.trending_down,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Dernières opérations',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  if (provider.transactions.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Center(
                        child: Text(
                          'Aucune transaction enregistrée',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ...provider.transactions.take(5).map(
                          (tx) => TransactionListItem(
                            transaction: tx,
                            onDelete: () => provider.deleteTransaction(tx.id),
                          ),
                        ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const AddTransactionScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle'),
        tooltip: 'Ajouter une transaction',
      ),
    );
  }
}
