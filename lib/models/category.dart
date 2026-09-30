import 'package:flutter/material.dart';

@immutable
class CategoryItem {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  static const List<CategoryItem> defaultCategories = [
    CategoryItem(id: 'salary', name: 'Salary', icon: Icons.work, color: Colors.green),
    CategoryItem(id: 'food', name: 'Food & Dining', icon: Icons.restaurant, color: Colors.orange),
    CategoryItem(id: 'transport', name: 'Transport', icon: Icons.directions_bus, color: Colors.blue),
    CategoryItem(id: 'bills', name: 'Bills & Utilities', icon: Icons.receipt, color: Colors.purple),
    CategoryItem(id: 'entertainment', name: 'Entertainment', icon: Icons.movie, color: Colors.pink),
    CategoryItem(id: 'health', name: 'Health & Care', icon: Icons.local_hospital, color: Colors.red),
  ];
}
