import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/utils/app_constants.dart' as app_constants;

class AppLocalization {
  final Locale locale;
  late Map<String, String> _localizedValues;

  AppLocalization(this.locale);

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  Future<void> load() async {
    final String jsonStringValues = await rootBundle.loadString('assets/language/${locale.languageCode}.json');
    final Map<String, dynamic> mappedJson = json.decode(jsonStringValues) as Map<String, dynamic>;
    _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate = _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final List<String> _languageString = [];
    for (int i = 0; i < app_constants.languages.length; i++) {
      _languageString.add(app_constants.languages[i].languageCode!);
    }
    return _languageString.contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    final AppLocalization localization = AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
