import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photodiary/components/photo_card.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// TabBar 实现
// 1. 首先需要with SingleTickerProviderStateMixin
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final tabs = ["人像", "风景", "写实", "写真", "微距", "航拍", "细节", "色调"];

  // 生命周期函数: 销毁时执行
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  // 2. State 类初始化时, 生成 _tabController
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    // 为 TabBarController 添加监听
    _tabController.addListener(
      () {
        print(_tabController.index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("摄影日记"),
          bottom: TabBar(
            // 3. TabBar 中添加 _tabController
            controller: _tabController,
            indicatorColor: Theme.of(context).buttonColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 4,
            isScrollable: true,
            tabs: [for (final tab in tabs) Tab(text: tab)],
          ),
        ),
        body: TabBarView(
          // 4. TabBarView 中添加 _tabController
          controller: _tabController,
          children: [
            Center(child: CardsDemo()),
            Center(child: Text("风景")),
            Center(child: Text("写实")),
            Center(child: Text("写真")),
            Center(child: Text("微距")),
            Center(child: Text("航拍")),
            Center(child: Text("细节")),
            Center(child: Text("色调")),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("Chenhao Wei"),
                accountEmail: Text("wchhm8050@gmail.com"),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1579546929662-711aa81148cf?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHw%3D&auto=format&fit=crop&w=500&q=60",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://lh3.googleusercontent.com/ogw/ADGmqu-SojQWiiu0b6YmdHiVhnYrRJ7RUnViywyn15tXWQ=s83-c-mo"),
                ),
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
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("设置项3"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("设置项4"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("设置项5"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("设置项6"),
              ),
            ],
          ),
        ),
        // endDrawer: Drawer(
        //   child: Text("右侧抽屉"),
        // ),
      ),
    );
  }
}
