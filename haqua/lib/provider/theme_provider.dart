import 'package:flutter/foundation.dart';

class ThemeProvider with ChangeNotifier {
  // final SharedPreferences sharedPreferences;
  // ThemeProvider({required this.sharedPreferences}) {
  //   _loadCurrentTheme();
  // }

  // bool _darkTheme = false;
  // bool get darkTheme => _darkTheme;

  // void toggleTheme() {
  //   _darkTheme = !_darkTheme;
  //   sharedPreferences.setBool(app_constants.THEME, _darkTheme);
  //   notifyListeners();
  // }

  // Future<void> _loadCurrentTheme() async {
  //   _darkTheme = sharedPreferences.getBool(app_constants.THEME) ?? false;
  //   notifyListeners();
  // }
}
