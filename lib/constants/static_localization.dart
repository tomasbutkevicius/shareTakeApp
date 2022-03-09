import 'package:flutter/material.dart';

class StaticLocalization {
  static const String languageCodeEnglish = "en";
  static const String languageCodeLithuanian = "lt";

  static const supportedLocales = [
    Locale(languageCodeEnglish),
    Locale(languageCodeLithuanian),
  ];

  static const englishLocale = Locale(languageCodeEnglish);

  static const lithuanianLocale = Locale(languageCodeLithuanian);

}