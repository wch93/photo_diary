import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Text(
            "登陆注册",
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
