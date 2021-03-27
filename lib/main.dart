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
        // 外层包裹Container来修改位置和大小
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: Colors.white,
          ),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add, size: 30),
            onPressed: () {},
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Center(
          child: IndexedStack(
            index: this._currentIndex,
            children: <Widget>[MyHomePage(), Profile()],
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
