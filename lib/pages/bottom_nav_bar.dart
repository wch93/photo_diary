import 'package:flutter/material.dart';
import 'package:photodiary/pages/home.dart';
import 'package:photodiary/pages/profile.dart';
import 'package:photodiary/util/const.dart';

class BottomNavPage extends StatefulWidget {
  BottomNavPage({Key key}) : super(key: key);

  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex;
  List _pageList = [
    HomePage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).buttonColor,
              foregroundColor: Colors.white,
              child: Icon(Icons.add, size: 30),
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.newPhotoPage);
              },
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: this._pageList[this._currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: this._currentIndex,
          onTap: (int index) {
            setState(() => this._currentIndex = index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: '我的',
            )
          ],
        ),
      ),
    );
  }
}
