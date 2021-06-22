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
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (BuildContext context, notifier, child) {
        return Scaffold(
          floatingActionButton: SafeArea(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
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
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
          drawer: Drawer(
            child: Consumer<UserInfoProvider>(
              builder: (context, userProvider, child) {
                return Column(
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
                        if (!userProvider.userInfo.loginStatus) {
                          Navigator.pushNamed(context, RoutesName.signInPage);
                        }
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("夜间模式"),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("设置项2"),
                    ),
                  ],
                );
              },
            ),
          ),
          body: CardsDemo(),
        );
      },
    );
  }
}
