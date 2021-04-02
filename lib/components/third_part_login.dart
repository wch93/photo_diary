//第三方登录区域
import 'package:flutter/material.dart';

Widget thirdLoginArea(context) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 60,
              height: 1.0,
              color: Colors.grey,
            ),
            Text('其他登录方式'),
            Container(
              width: 60,
              height: 1.0,
              // color: Colors.grey,
            ),
          ],
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              color: Theme.of(context).iconTheme.color,
              // 第三方库icon图标
              icon: Icon(Icons.people),
              iconSize: 35.0,
              onPressed: () {},
            ),
            IconButton(
              color: Theme.of(context).iconTheme.color,
              icon: Icon(Icons.people),
              iconSize: 35.0,
              onPressed: () {},
            ),
            IconButton(
              color: Theme.of(context).iconTheme.color,
              icon: Icon(Icons.people),
              iconSize: 35.0,
              onPressed: () {},
            )
          ],
        )
      ],
    ),
  );
}
