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
