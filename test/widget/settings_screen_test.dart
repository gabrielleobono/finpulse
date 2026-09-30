import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:finpulse/providers/finance_provider.dart';
import 'package:finpulse/screens/settings_screen.dart';

void main() {
  testWidgets('W5. SettingsScreen active le mode sombre via le Switch', (tester) async {
    final provider = FinanceProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: provider,
        child: const MaterialApp(
          home: SettingsScreen(),
        ),
      ),
    );

    expect(find.text('Mode Sombre (Dark Mode)'), findsOneWidget);
    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);

    await tester.tap(switchFinder);
    await tester.pump();

    expect(provider.themeMode, ThemeMode.dark);
  });
}
