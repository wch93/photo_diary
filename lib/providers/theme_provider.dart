import 'package:flutter/material.dart';
import 'package:photodiary/util/const.dart';
import 'package:sp_util/sp_util.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  accentColor: Colors.indigo,
  buttonColor: Colors.indigo,
  colorScheme: ColorScheme.light(),
  splashColor: Colors.transparent,
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.pink,
  accentColor: Colors.pink,
  buttonColor: Colors.pink,
  colorScheme: ColorScheme.dark(),
  splashColor: Colors.transparent,
);

class ThemeNotifier extends ChangeNotifier {
  bool darkTheme;

  ThemeNotifier() {
    darkTheme = SpUtil.getBool(Constants.theme) ?? false;
    SpUtil.putBool(Constants.theme, darkTheme);
  }

  toggleTheme() {
    darkTheme = !darkTheme;
    SpUtil.putBool(Constants.theme, darkTheme);
    notifyListeners();
  }
}
