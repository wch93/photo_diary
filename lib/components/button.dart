import 'package:flutter/material.dart';

Widget button(context, String label, Function onPress) {
  return Container(
    // margin: EdgeInsets.only(left: 40, right: 40),
    height: 45.0,
    child: ElevatedButton(
      style: ButtonStyle(
        //定义文本的样式 这里设置的颜色是不起作用的
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 18, color: Colors.red),
        ),
        //背景颜色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //默认不使用背景颜色
          return Theme.of(context).buttonColor;
        }),
        //设置按钮内边距
        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
        //设置按钮的大小
        minimumSize: MaterialStateProperty.all(Size(200, 100)),
        //外边框装饰 会覆盖 side 配置的样式
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).primaryTextTheme.button,
      ),
      onPressed: onPress,
    ),
  );
}
