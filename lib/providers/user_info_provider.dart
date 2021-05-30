import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photodiary/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  String userPhone, userName, password, avatarUrl;
  bool needVerification, loginStatus;
  UserInfo({userPhone, userName, password, avatarUrl, needVerification, loginStatus}) {
    this.userPhone = userPhone;
    this.userName = userName;
    this.password = password;
    this.avatarUrl = avatarUrl;
    this.needVerification = needVerification;
    this.loginStatus = loginStatus;
  }
}

class UserInfoProvider extends ChangeNotifier {
  UserInfo userInfo = UserInfo(needVerification: true, loginStatus: false);
  SharedPreferences _pref;

  _initPrefs() async {
    if (_pref == null) _pref = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    userInfo.userPhone = _pref.getString(Constants.userPhone) ?? '';
    userInfo.password = _pref.getString(Constants.password) ?? '';
    userInfo.userName = _pref.getString(Constants.userName) ?? '';
    userInfo.avatarUrl = _pref.getString(Constants.avatarUrl) ?? '';
    userInfo.needVerification = _pref.getBool(Constants.needVerification) ?? true;
    userInfo.loginStatus = _pref.getBool(Constants.loginStatus) ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _pref.setString(Constants.userName, userInfo.userName);
    _pref.setString(Constants.userPhone, userInfo.userPhone);
    _pref.setString(Constants.avatarUrl, userInfo.avatarUrl);
    _pref.setString(Constants.password, userInfo.password);
    _pref.setBool(Constants.needVerification, userInfo.needVerification);
    _pref.setBool(Constants.loginStatus, userInfo.loginStatus);
  }

  UserInfoProvider() {
    _loadFromPrefs();
  }

  saveUserInfo() {
    _saveToPrefs();
    notifyListeners();
  }
}
