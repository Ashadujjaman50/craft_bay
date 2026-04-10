import 'package:craft_bay/app/extensions/localization_extension.dart';
import 'package:craft_bay/app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {

    final languageProvider = context.read<LanguageProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.hello)),
      body: Column(
        children: [
          // FilledButton(
          //   onPressed: () {
          //     Locale local = languageProvider.currentLocale;
          //     if (local == Locale('en')) {
          //       languageProvider.changeLanguage(Locale('bn'));
          //     } else {
          //       languageProvider.changeLanguage(Locale('en'));
          //     }
          //   },
          //   child: Text("Change Language"),
          // ),
          Text(context.l10n.changeYourLanguage),
          DropdownMenu(
            dropdownMenuEntries: languageProvider.supportedLocales
                .map((e) {
                  return DropdownMenuEntry(value: e, label: e.languageCode);
                })
                .toList(),
            initialSelection: languageProvider.currentLocale,
            onSelected: (value) {
              languageProvider.changeLanguage(value!);
            },
          ),
        ],
      ),
    );
  }
}
