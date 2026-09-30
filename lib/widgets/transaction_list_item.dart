import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionListItem extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback? onDelete;

  const TransactionListItem({
    super.key,
    required this.transaction,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final color = isIncome ? Colors.green : Colors.red;
    final prefix = isIncome ? '+' : '-';
    final formattedDate = DateFormat('MMM dd, yyyy').format(transaction.date);

    return Semantics(
      label: '${transaction.title}, $prefix\$${transaction.amount.toStringAsFixed(2)}, ${transaction.category}, $formattedDate',
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color.withOpacity(0.12),
            child: Icon(
              isIncome ? Icons.arrow_downward : Icons.arrow_upward,
              color: color,
            ),
          ),
          title: Text(
            transaction.title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text('${transaction.category} • $formattedDate'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$prefix\$${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              if (onDelete != null)
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.grey),
                  tooltip: 'Supprimer',
                  onPressed: onDelete,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
