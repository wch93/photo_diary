import 'dart:io';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photodiary/pages/home.dart';
import 'package:photodiary/providers/theme_provider.dart';
import 'package:photodiary/providers/user_info_provider.dart';
import 'package:photodiary/util/routes.dart';
import 'package:photodiary/util/util.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
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
          debugShowCheckedModeBanner: false,
          theme: notifier.darkTheme ? dark : light,
          // 双击退出
          home: DoubleBack(
            message: '再次点击退出',
            child: HomePage(),
          ),
          routes: routes,
          // 针对安卓的优化
          builder: (BuildContext context, Widget child) {
            /// 仅针对安卓
            if (Platform.isAndroid) {
              /// 切换深色模式会触发此方法，这里设置导航栏颜色
              PhotoUtil.setSystemNavigationBar(notifier.darkTheme);
            }

            /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child,
            );
          },
        );
      },
    );
  }
}
