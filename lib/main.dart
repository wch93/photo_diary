import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photodiary/pages/home.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
          // primaryColorDark: Colors.blue,
          primaryColorBrightness: Brightness.dark,
          // highlightColor: Colors.transparent,
          // splashColor: Colors.transparent,
        ),
        title: "摄影日记",
        home: MyHomePage(),
      ),
    );
  }
}
