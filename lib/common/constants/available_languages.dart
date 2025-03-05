import 'package:flutter/material.dart';

final availableLanguages = [
  Language('English', const Locale('en')), // English
  Language('العربية', const Locale('ar')), // Arabic
  Language('کوردی', const Locale('ku')), // Kurdish
  // Language('فارسی', const Locale('fa')), // Persian
  // Language('Türkçe', const Locale('tr')), // Turkish
  // Language('Deutsch', const Locale('de')), // German
  // Language('Français', const Locale('fr')), // French
  // Language('中文', const Locale('zh-CN')), // Chinese
  // Language('हिन्दी', const Locale('hi')), // Hindi
  // Language('اردو', const Locale('ur')), // Urdu
];

String getLanguageNamesByCode(String code) {
  return switch (code) {
    'en' => 'English',
    'ar' => 'العربية',
    'ku' => 'کوردی',
    'fa' => 'فارسی',
    'tr' => 'Türkçe',
    'de' => 'Deutsch',
    'fr' => 'Français',
    'zh' => '中文',
    'hi' => 'हिन्दी',
    'ur' => 'اردو',
    _ => 'Unknown',
  };
}

class Language {
  Language(this.name, this.locale);
  final String name;
  final Locale locale;
}
