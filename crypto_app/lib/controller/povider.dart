import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModes with ChangeNotifier {
  bool _mode;
  String key = 'theme';
  SharedPreferences prefs;
  bool get themeModes => _mode;

  ThemeModes() {
    _mode = true;
    getTheme();
  }

  _initPref() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  getMode() {
    _mode = !_mode;
    saveTheme(_mode);

    print(_mode);
    notifyListeners();
  }

  getTheme() async {
    await _initPref();
    _mode = prefs.getBool(key) ?? false;
    notifyListeners();
  }

  saveTheme(bool value) async {
    await _initPref();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(key, value);
  }
}

class SaveCurrency {
  static SharedPreferences prefs;

  String money;

  initPref() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  factory SaveCurrency() => SaveCurrency._internal();

  SaveCurrency._internal();

  String get getMoney => prefs.getString('currency') ?? 'USD';

  saveData(String value) async {
    await initPref();

    prefs.setString('currency', value);
  }
}
