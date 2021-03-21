import 'package:flutter/material.dart';
import 'package:photodiary/components/photo_card.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final tabs = ["人像", "风景", "写实", "写真", "微距", "航拍", "细节", "色调"];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("摄影日记"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [for (final tab in tabs) Tab(text: tab)],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: CardsDemo()),
            Center(child: Text("占位")),
            Center(child: Text("占位")),
            Center(child: Text("占位")),
            Center(child: Text("占位")),
            Center(child: Text("占位")),
            Center(child: Text("占位")),
            Center(child: Text("占位")),
          ],
        ),
      ),
    );
  }
}
