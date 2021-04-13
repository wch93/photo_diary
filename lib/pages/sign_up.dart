import 'package:flutter/material.dart';
import 'package:photodiary/components/button.dart';
import 'package:photodiary/components/logo.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = "sign_up";
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //焦点
  FocusNode _focusNodeUserName = FocusNode();
  FocusNode _focusNodePassWord = FocusNode();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _userNameController = TextEditingController();

  //表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _password = ''; //用户名
  var _username = ''; //密码
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
    RegExp exp = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      return '手机号不能为空';
    } else if (!exp.hasMatch(value)) {
      return '请输入正确手机号';
    }
    return null;
  }

  // 验证密码
  String validatePassWord(value) {
    if (value.isEmpty) {
      return '验证码不能为空';
    } else if (value.trim().length != 6 || value.runtimeType != int) {
      return '请输入 6 位数字验证码';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //输入文本框区域
    Widget inputTextArea = Container(
      margin: EdgeInsets.only(left: 30, right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _userNameController,
              focusNode: _focusNodeUserName,
              //设置键盘类型
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "手机号",
                hintText: "请输入手机号",
                prefixText: "+86 ",
                prefixIcon: Icon(Icons.person),
                //尾部添加清除按钮
                suffixIcon: (_isShowClear)
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => _userNameController.clear(),
                        // 清空输入框内容
                      )
                    : null,
              ),
              //验证用户名
              validator: validateUserName,
              //保存数据
              onSaved: (String value) {
                _username = value;
                print(_username);
              },
            ),
            TextFormField(
              focusNode: _focusNodePassWord,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "验证码",
                hintText: "请输入验证码",
                prefixIcon: Icon(Icons.verified_user_rounded),
              ),
              //密码验证
              validator: validatePassWord,
              //保存数据
              onSaved: (String value) {
                _password = value;
                print(_password);
              },
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
      ),
      // 外层添加一个手势，用于点击空白部分，回收键盘
      body: GestureDetector(
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
              SizedBox(height: 50),
              logoImageArea(context),
              SizedBox(height: 50),
              inputTextArea,
              SizedBox(height: 30),
              button(context, "发送验证码", () {}),
              SizedBox(height: 30),
              button(context, "注册", () {}),
            ],
          ),
        ),
      ),
    );
  }
}
