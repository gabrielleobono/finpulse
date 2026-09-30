import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FinanceProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres & Accessibilité'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Mode Sombre (Dark Mode)'),
            subtitle: const Text('Activer le thème sombre haute lisibilité'),
            value: provider.themeMode == ThemeMode.dark,
            onChanged: (val) => provider.toggleTheme(val),
            secondary: const Icon(Icons.brightness_6),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Langue de l’application'),
            subtitle: Text(provider.locale.languageCode == 'fr' ? 'Français' : 'English'),
            trailing: DropdownButton<String>(
              value: provider.locale.languageCode,
              onChanged: (val) {
                if (val != null) {
                  provider.setLocale(Locale(val));
                }
              },
              items: const [
                DropdownMenuItem(value: 'fr', child: Text('Français')),
                DropdownMenuItem(value: 'en', child: Text('English')),
              ],
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.accessibility_new),
            title: Text('Mode Accessibilité'),
            subtitle: Text('Semantics labels actifs pour les lecteurs d’écran'),
            trailing: Icon(Icons.check_circle, color: Colors.green),
          ),
          const ListTile(
            leading: Icon(Icons.verified),
            title: Text('Version'),
            subtitle: Text('FinPulse Pro v1.0.0 (Build production-ready)'),
          ),
        ],
      ),
    );
  }
}
