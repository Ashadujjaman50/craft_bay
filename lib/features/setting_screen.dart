import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/extensions/localization_extension.dart';
import '../app/providers/language_provider.dart';
import '../app/providers/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {

    final languageProvider = context.watch<LanguageProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.hello)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.changeYourLanguage),
            const SizedBox(height: 8),
            DropdownMenu<Locale>(
              dropdownMenuEntries: languageProvider.supportedLocales
                  .map((e) {
                return DropdownMenuEntry(value: e, label: e.languageCode.toUpperCase());
              })
                  .toList(),
              initialSelection: languageProvider.currentLocale,
              onSelected: (value) {
                if (value != null) {
                  languageProvider.changeLanguage(value);
                }
              },
            ),
            const SizedBox(height: 24),
            Text(context.l10n.changeTheme),
            const SizedBox(height: 8),
            DropdownMenu<ThemeMode>(
              initialSelection: themeProvider.themeMode,
              onSelected: (value) {
                if (value != null) {
                  themeProvider.setThemeMode(value);
                }
              },
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: ThemeMode.system, label: 'System'),
                DropdownMenuEntry(value: ThemeMode.light, label: 'Light'),
                DropdownMenuEntry(value: ThemeMode.dark, label: 'Dark'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
