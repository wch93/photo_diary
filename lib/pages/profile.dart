import 'package:flutter/material.dart';
import 'package:photodiary/pages/sign_in.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignInPage(),
    );
  }
}
