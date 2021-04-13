import 'package:flutter/material.dart';
import 'package:photodiary/components/photo_card.dart';
import 'package:photodiary/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (BuildContext context, notifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("摄影日记"),
            actions: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(notifier.darkTheme ? Icons.brightness_2 : Icons.brightness_high),
                    onPressed: () => notifier.toggleTheme(),
                  ),
                ),
              )
            ],
          ),
          body: CardsDemo(),
        );
      },
    );
  }
}
