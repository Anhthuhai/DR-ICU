import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'app_language';
  
  static Future<Locale> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageKey) ?? 'vi'; // Default to Vietnamese
    return Locale(languageCode);
  }
  
  static Future<void> setLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }
  
  static List<Locale> getSupportedLocales() {
    return const [
      Locale('en'), // English
      Locale('vi'), // Vietnamese
    ];
  }
}
