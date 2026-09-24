import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleService {
  LocaleService._();

  static const _key = 'locale';

  static Future<Locale?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code == null) return null;              // null = follow system
    return Locale(code);
  }

  static Future<void> save(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove(_key);
    } else {
      await prefs.setString(_key, locale.languageCode);
    }
  }
}


class LocaleController {
  LocaleController._();

  static final ValueNotifier<Locale?> current = ValueNotifier<Locale?>(null);

  static Future<void> load() async {
    current.value = await LocaleService.load();
  }

  static Future<void> set(Locale? locale) async {
    current.value = locale;
    await LocaleService.save(locale);
  }
}
