import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemesService extends ChangeNotifier {
  final SharedPreferences _preferences;

  ThemesService(this._preferences);

  void saveTheme(bool isDark) {
    _preferences.setBool("currentTheme", isDark);
  }

  bool getCurrentTheme() {
    return _preferences.getBool("currentTheme") ?? false;
  }

  void changeTheme() {
    saveTheme(!getCurrentTheme());
    notifyListeners();
  }

  ThemeMode get themeMode =>
      getCurrentTheme() ? ThemeMode.dark : ThemeMode.light;
}
