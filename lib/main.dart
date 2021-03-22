import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photodiary/pages/home.dart';
import 'package:photodiary/pages/profile.dart';
import 'package:photodiary/pages/signup.dart';

main(List<String> args) => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // debugShowMaterialGrid: true,
        theme: ThemeData(
          primaryColor: Colors.green,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        home: MyStackPage(),
        routes: {
          "signup": (context) => SignUpPage(),
        },
      ),
    );
  }
}

class MyStackPage extends StatefulWidget {
  MyStackPage({Key key}) : super(key: key);

  @override
  _MyStackPageState createState() => _MyStackPageState();
}

class _MyStackPageState extends State<MyStackPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: IndexedStack(
            index: this._currentIndex,
            children: <Widget>[
              MyHomePage(),
              Profile(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.account_box), label: "我的"),
          ],
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
