// logo 图片区域
import 'package:flutter/material.dart';

Widget logoImageArea(context) {
  return Container(
    alignment: Alignment.topCenter,
    // 设置图片为圆形
    child: Image.asset(
      Theme.of(context).brightness == Brightness.light
          ? "assets/icon_black_transparent.png"
          : "assets/icon_white_transparent.png",
      height: 150,
      width: 150,
      fit: BoxFit.cover,
    ),
  );
}
