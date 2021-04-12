import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:photodiary/components/photo_card.dart';
import 'package:photodiary/providers/theme_provider.dart';
import 'package:photodiary/providers/user_info_provider.dart';
import 'package:photodiary/util/const.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (BuildContext context, notifier, child) {
        return Scaffold(
            floatingActionButton: SafeArea(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 20, 20),
                child: FloatingActionButton(
                  // backgroundColor: settings.currentTheme.primaryColor,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.add, size: 30),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.newPhotoPage);
                  },
                ),
              ),
            ),
            appBar: AppBar(
              title: Text("摄影日记"),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings_brightness_outlined),
                  onPressed: () => notifier.toggleTheme(),
                )
              ],
            ),
            body: CardsDemo(),
            drawer: Consumer<UserInfoProvider>(
              builder: (context, userProvider, child) {
                return Drawer(
                  child: Column(
                    children: [
                      GestureDetector(
                        child: UserAccountsDrawerHeader(
                          accountName: userProvider.userInfo.loginStatus
                              ? Text(userProvider.userInfo.userName)
                              : Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 8),
                                  child: Text("点击登录", style: TextStyle(color: Colors.white)),
                                ),
                          accountEmail: Padding(padding: const EdgeInsets.fromLTRB(8, 0, 0, 5)),
                          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                          currentAccountPicture: ClipOval(
                            child: userProvider.userInfo.avatarUrl == ''
                                ? Image.asset('assets/icon_white_transparent.png')
                                : ExtendedImage.network(
                                    // "https://lh3.googleusercontent.com/ogw/ADGmqu-SojQWiiu0b6YmdHiVhnYrRJ7RUnViywyn15tXWQ=s83-c-mo",
                                    userProvider.userInfo.avatarUrl,
                                    fit: BoxFit.cover,
                                    cache: true,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                          ),
                        ),
                        onTap: () {
                          if (!userProvider.userInfo.loginStatus) Navigator.pushNamed(context, RoutesName.signInPage);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text("设置项1"),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text("设置项2"),
                      ),
                    ],
                  ),
                );
              },
            ));
      },
    );
  }
}
