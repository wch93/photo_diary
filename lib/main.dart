import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photodiary/pages/home.dart';
import 'package:photodiary/pages/sign_in.dart';
import 'package:photodiary/pages/sign_up.dart';
import 'package:photodiary/util/provider.dart';
import 'package:provider/provider.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState<T extends ChangeNotifier> extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<Settings>.value(value: Settings.settings),
      ],
      child: Consumer<Settings>(
        builder: (BuildContext context, settings, _) {
          return MaterialApp(
            theme: settings.currentTheme,
            home: MyHomePage(),
            routes: {
              SignUpPage.routeName: (context) => SignUpPage(),
              SignInPage.routeName: (context) => SignInPage(),
            },
          );
        },
      ),
    );
  }
}
