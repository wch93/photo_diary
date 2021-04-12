import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photodiary/pages/home.dart';
import 'package:photodiary/pages/new_photo.dart';
import 'package:photodiary/pages/sign_in.dart';
import 'package:photodiary/pages/sign_up.dart';
import 'package:photodiary/providers/theme_provider.dart';
import 'package:photodiary/providers/user_info_provider.dart';
import 'package:photodiary/util/const.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

main(List<String> args) async {
  await SpUtil.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ChangeNotifierProvider(create: (_) => UserInfoProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState<T extends ChangeNotifier> extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) {
        return MaterialApp(
          theme: notifier.darkTheme ? dark : light,
          home: HomePage(),
          routes: {
            RoutesName.signInPage: (context) => SignInPage(),
            RoutesName.signUpPage: (context) => SignUpPage(),
            RoutesName.newPhotoPage: (context) => NewPhotoPage(),
          },
        );
      },
    );
  }
}
