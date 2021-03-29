import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photodiary/pages/home.dart';
import 'package:photodiary/pages/sign_in.dart';
import 'package:photodiary/pages/sign_up.dart';

main(List<String> args) {
  runApp(MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          navigationRailTheme:
              NavigationRailThemeData(backgroundColor: Colors.transparent),
          primaryColor: Colors.blueGrey,
          // brightness: Brightness.dark,
          // primaryColorBrightness: Brightness.dark,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        home: MyHomePage(),
        routes: {
          SignUpPage.routeName: (context) => SignUpPage(),
          SignInPage.routeName: (context) => SignInPage(),
        },
      ),
    );
  }
}
