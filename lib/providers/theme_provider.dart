import 'package:flutter/material.dart';
import 'package:photodiary/util/const.dart';
import 'package:sp_util/sp_util.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  accentColor: Colors.pink,
  scaffoldBackgroundColor: Color(0xfff1f1f1),
  buttonColor: Colors.pink,
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.indigo,
  accentColor: Colors.pink,
  buttonColor: Colors.pink,
  iconTheme: IconThemeData(color: Colors.grey),
);

class ThemeNotifier extends ChangeNotifier {
  bool _darkTheme;
  bool get darkTheme => _darkTheme;

  _saveToPrefs() {
    SpUtil.putBool(Constants.theme, _darkTheme);
    notifyListeners();
  }

  ThemeNotifier() {
    _darkTheme = SpUtil.getBool(Constants.theme) ?? false;
    _saveToPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }
}
