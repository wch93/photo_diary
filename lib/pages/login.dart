import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //焦点
  FocusNode _focusNodeUserName = new FocusNode();
  FocusNode _focusNodePassWord = new FocusNode();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _userNameController = new TextEditingController();

  //表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _password = ''; //用户名
  var _username = ''; //密码
  var _isShowPwd = false; //是否显示密码
  var _isShowClear = false; //是否显示输入框尾部的清除按钮

  @override
  void initState() {
    //设置焦点监听
    _focusNodeUserName.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);
    //监听用户名框的输入改变
    _userNameController.addListener(() {
      print(_userNameController.text);

      // 监听文本框输入变化，当有内容的时候，显示尾部清除按钮，否则不显示
      if (_userNameController.text.length > 0) {
        _isShowClear = true;
      } else {
        _isShowClear = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // 移除焦点监听
    _focusNodeUserName.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userNameController.dispose();
    super.dispose();
  }

  // 监听焦点
  Future<Null> _focusNodeListener() async {
    if (_focusNodeUserName.hasFocus) {
      print("用户名框获取焦点");
      // 取消密码框的焦点状态
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      print("密码框获取焦点");
      // 取消用户名框焦点状态
      _focusNodeUserName.unfocus();
    }
  }

  // 验证用户名
  String validateUserName(value) {
    // 正则匹配手机号
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '用户名不能为空!';
    } else if (!exp.hasMatch(value)) {
      return '请输入正确手机号';
    }
    return null;
  }

  // 验证密码
  String validatePassWord(value) {
    if (value.isEmpty) {
      return '密码不能为空';
    } else if (value.trim().length < 6 || value.trim().length > 18) {
      return '密码长度不正确';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            minWidth: 750, minHeight: 1334, maxWidth: 750, maxHeight: 1334),
        Orientation.landscape);
    // ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    print(ScreenUtil().scaleHeight);

    // logo 图片区域
    Widget logoImageArea = new Container(
      alignment: Alignment.topCenter,
      // 设置图片为圆形
      child: Image.asset(
        "assets/logo.png",
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
    );

    //输入文本框区域
    Widget inputTextArea = new Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: new Form(
        key: _formKey,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new TextFormField(
              controller: _userNameController,
              focusNode: _focusNodeUserName,
              //设置键盘类型
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "用户名",
                hintText: "请输入手机号",
                prefixIcon: Icon(Icons.person),
                //尾部添加清除按钮
                suffixIcon: (_isShowClear)
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          // 清空输入框内容
                          _userNameController.clear();
                        },
                      )
                    : null,
              ),
              //验证用户名
              validator: validateUserName,
              //保存数据
              onSaved: (String value) {
                _username = value;
              },
            ),
            new TextFormField(
              focusNode: _focusNodePassWord,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                  // 是否显示密码
                  suffixIcon: IconButton(
                    icon: Icon(
                        (_isShowPwd) ? Icons.visibility : Icons.visibility_off),
                    // 点击改变显示或隐藏密码
                    onPressed: () {
                      setState(() {
                        _isShowPwd = !_isShowPwd;
                      });
                    },
                  )),
              obscureText: !_isShowPwd,
              //密码验证
              validator: validatePassWord,
              //保存数据
              onSaved: (String value) {
                _password = value;
              },
            )
          ],
        ),
      ),
    );

    // 登录按钮区域
    Widget loginButtonArea = new Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      height: 45.0,
      child: ElevatedButton(
        style: ButtonStyle(
          //定义文本的样式 这里设置的颜色是不起作用的
          textStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 18, color: Colors.red),
          ),
          //设置按钮上字体与图标的颜色
          //foregroundColor: MaterialStateProperty.all(Colors.deepPurple),
          //更优美的方式来设置
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.focused) &&
                  !states.contains(MaterialState.pressed)) {
                //获取焦点时的颜色
                return Colors.blue;
              } else if (states.contains(MaterialState.pressed)) {
                //按下时的颜色
                return Colors.deepPurple;
              }
              //默认状态使用灰色
              return Colors.grey;
            },
          ),
          //背景颜色
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            //设置按下时的背景颜色
            // if (states.contains(MaterialState.pressed)) {
            //   return Theme.of(context).primaryColor;
            // }
            //默认不使用背景颜色
            return Theme.of(context).primaryColor;
          }),
          //设置水波纹颜色
          // overlayColor: MaterialStateProperty.all(Colors.yellow),
          //设置阴影  不适用于这里的TextButton
          elevation: MaterialStateProperty.all(0),
          //设置按钮内边距
          padding: MaterialStateProperty.all(EdgeInsets.all(10)),
          //设置按钮的大小
          minimumSize: MaterialStateProperty.all(Size(200, 100)),
          //设置边框
          side: MaterialStateProperty.all(
              BorderSide(color: Colors.grey, width: 1)),
          //外边框装饰 会覆盖 side 配置的样式
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
        ),
        child: Text(
          "登录",
          style: Theme.of(context).primaryTextTheme.subtitle1,
        ),
        // 设置按钮圆角
        // shape:
        //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: () {
          //点击登录按钮，解除焦点，回收键盘
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();

          if (_formKey.currentState.validate()) {
            //只有输入通过验证，才会执行这里
            _formKey.currentState.save();
            //todo 登录操作
            print("$_username + $_password");
          }
        },
      ),
    );

    //第三方登录区域
    Widget thirdLoginArea = new Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 60,
                height: 1.0,
                color: Colors.grey,
              ),
              Text('其他登录方式'),
              Container(
                width: 60,
                height: 1.0,
                color: Colors.grey,
              ),
            ],
          ),
          new SizedBox(
            height: 18,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                color: Theme.of(context).primaryColor,
                // 第三方库icon图标
                icon: Icon(FontAwesomeIcons.weixin),
                iconSize: 35.0,
                onPressed: () {},
              ),
              IconButton(
                color: Theme.of(context).primaryColor,
                icon: Icon(FontAwesomeIcons.facebook),
                iconSize: 35.0,
                onPressed: () {},
              ),
              IconButton(
                color: Theme.of(context).primaryColor,
                icon: Icon(FontAwesomeIcons.qq),
                iconSize: 35.0,
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );

    //忘记密码  立即注册
    Widget bottomArea = new Container(
      margin: EdgeInsets.only(right: 50, left: 50),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            child: Text(
              "忘记密码?",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16.0,
              ),
            ),
            //忘记密码按钮，点击执行事件
            onPressed: () {},
          ),
          TextButton(
            child: Text(
              "快速注册",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16.0,
              ),
            ),
            //点击快速注册、执行事件
            onPressed: () async {
              await Navigator.pushNamed(context, "signup");
            },
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      backgroundColor: Colors.white,
      // 外层添加一个手势，用于点击空白部分，回收键盘
      body: new GestureDetector(
        onTap: () {
          // 点击空白区域，回收键盘
          print("点击了空白区域");
          _focusNodePassWord.unfocus();
          _focusNodeUserName.unfocus();
        },
        child: Container(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(50)),
              logoImageArea,
              SizedBox(height: ScreenUtil().setHeight(40)),
              inputTextArea,
              SizedBox(height: ScreenUtil().setHeight(30)),
              loginButtonArea,
              SizedBox(height: ScreenUtil().setHeight(30)),
              thirdLoginArea,
              SizedBox(height: ScreenUtil().setHeight(10)),
              bottomArea,
            ],
          ),
        ),
      ),
    );
  }
}
