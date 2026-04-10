import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {

  Locale _currentLocale = Locale("en");

  List<Locale> supportedLocales = [
    Locale("en"),
    Locale("bn"),
  ];

  Locale get currentLocale => _currentLocale;

  void changeLanguage(Locale locale) {
    _currentLocale = locale;
    notifyListeners();
  }


}