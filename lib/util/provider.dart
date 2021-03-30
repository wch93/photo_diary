import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  accentColor: Colors.pink,
  scaffoldBackgroundColor: Color(0xfff1f1f1),
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.indigo,
  accentColor: Colors.pink,
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _pref;
  bool _darkTheme;
  bool get darkTheme => _darkTheme;

  // _initPref() is to iniliaze  the _pref variable
  _initPrefs() async {
    if (_pref == null) _pref = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _pref.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _pref.setBool(key, _darkTheme);
  }

  // 构造函数初始化主题
  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs(); // add this line
  }
  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }
}
