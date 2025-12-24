import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resistor_calculator/theme_provider.dart';
import 'package:resistor_calculator/widgets/app_bar_back.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: const AppBarBack(title: 'Settings'),
      body: ListView(
        children: [
          ListTile(
            title: Text('Theme', style: Theme.of(context).textTheme.titleLarge),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonFormField<ThemeMode>(
              initialValue: themeProvider.themeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Default'),
                ),
              ],
              onChanged: (ThemeMode? newValue) {
                if (newValue != null) {
                  switch (newValue) {
                    case ThemeMode.light:
                      themeProvider.toggleTheme(false);
                      break;
                    case ThemeMode.dark:
                      themeProvider.toggleTheme(true);
                      break;
                    case ThemeMode.system:
                      themeProvider.setSystemTheme();
                      break;
                  }
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
