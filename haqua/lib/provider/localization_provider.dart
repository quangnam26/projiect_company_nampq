// import 'package:flutter/material.dart';
// import 'package:template/utils/app_constants.dart' as app_constants;
// import 'package:shared_preferences/shared_preferences.dart';

// class LocalizationProvider extends ChangeNotifier {
//   final SharedPreferences sharedPreferences;

//   LocalizationProvider({required this.sharedPreferences}) {
//     _loadCurrentLanguage();
//   }

//   Locale _locale = Locale(app_constants.languages[0].languageCode!, app_constants.languages[0].countryCode);
//   bool _isLtr = true;
//   int? _languageIndex;

//   Locale get locale => _locale;
//   bool get isLtr => _isLtr;
//   int? get languageIndex => _languageIndex;

//   void setLanguage(Locale locale) {
//     _locale = locale;
//     _isLtr = _locale.languageCode != 'ar';
//     for(int index=0; index<app_constants.languages.length; index++) {
//       if(app_constants.languages[index].languageCode == locale.languageCode) {
//         _languageIndex = index;
//         break;
//       }
//     }
//     _saveLanguage(_locale);
//     notifyListeners();
//   }

//   Future<void> _loadCurrentLanguage() async {
//     _locale = Locale(sharedPreferences.getString(app_constants.LANGUAGE_CODE) ?? app_constants.languages[0].languageCode!,
//         sharedPreferences.getString(app_constants.COUNTRY_CODE) ?? app_constants.languages[0].countryCode);
//     _isLtr = _locale.languageCode != 'ar';
//     for(int index=0; index<app_constants.languages.length; index++) {
//       if(app_constants.languages[index].languageCode == locale.languageCode) {
//         _languageIndex = index;
//         break;
//       }
//     }
//     notifyListeners();
//   }

//   Future<void> _saveLanguage(Locale locale) async {
//     sharedPreferences.setString(app_constants.LANGUAGE_CODE, locale.languageCode);
//     sharedPreferences.setString(app_constants.COUNTRY_CODE, locale.countryCode!);
//   }
// }