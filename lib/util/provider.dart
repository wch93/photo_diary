import 'package:flutter/material.dart';
import 'package:photodiary/util/const.dart';
import 'package:photodiary/util/util.dart';

class Settings with ChangeNotifier {
  static Settings settings = Settings();

  ThemeData _currentTheme;
  get currentTheme => _currentTheme;

  ThemeData _themeLight = ThemeData(
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: Colors.transparent,
    ),
    // brightness: Brightness.dark,
    // primaryColorBrightness: Brightness.dark,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    primaryColor: Colors.blueGrey,
    brightness: Brightness.light,
  );

  ThemeData _themeDark = ThemeData(
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: Colors.transparent,
    ),
    // brightness: Brightness.dark,
    // primaryColorBrightness: Brightness.dark,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    brightness: Brightness.dark,
  );

  // 构造函数初始化主题
  Settings() {
    if (PhotoUtil.getBool(Constants.darkMode) == false) {
      _currentTheme = _themeLight;
    } else if (PhotoUtil.getBool(Constants.darkMode) == true) {
      _currentTheme = _themeDark;
    } else {
      _currentTheme = _themeLight;
    }
  }

  // 暗黑模式和亮色模式切换
  void changeBrightness() {
    if (_currentTheme == _themeLight) {
      _currentTheme = _themeDark;
      PhotoUtil.setBool(Constants.darkMode, true);
    } else {
      _currentTheme = _themeLight;
      PhotoUtil.setBool(Constants.darkMode, false);
    }
    notifyListeners();
  }
}
