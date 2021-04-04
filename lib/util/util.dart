import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PhotoUtil {
  // 验证用户名
  static String validatePhone(value) {
    // 正则匹配手机号
    RegExp exp = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '用户名不能为空!';
    } else if (!exp.hasMatch(value)) {
      return '请输入正确手机号';
    }
    return null;
  }

  // 验证密码
  static String validatePassWord(value) {
    if (value.isEmpty) {
      return '密码不能为空';
    } else if (value.trim().length < 6 || value.trim().length > 18) {
      return '密码长度不正确';
    }
    return null;
  }

  // 弹出对话框
  static alertDialog(context, String title, String content) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("确定"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("取消"),
            ),
          ],
        );
      },
    );
  }

  static simpleDialog(context, String title) async {
    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(title),
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("确定"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("取消"),
            ),
          ],
        );
      },
    );
  }
}
