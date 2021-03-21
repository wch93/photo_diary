import 'package:flutter/material.dart';
import 'package:photodiary/pages/login.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("登录"),
        ),
        body: LoginPage(),
      ),
    );
  }
}
