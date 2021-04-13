import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photodiary/components/button.dart';
import 'package:photodiary/components/logo.dart';
import 'package:photodiary/pages/sign_up.dart';
import 'package:photodiary/providers/user_info_provider.dart';
import 'package:photodiary/util/const.dart';
import 'package:photodiary/util/util.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  static const routeName = RoutesName.signInPage;
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //焦点
  FocusNode _focusNodeUserPhone = FocusNode();
  FocusNode _focusNodePassWord = FocusNode();

  //用户名输入框控制器，此控制器可以监听用户名输入框操作
  TextEditingController _userPhoneController = TextEditingController();

  //表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _isShowPwd = false; //是否显示密码

  @override
  void initState() {
    //设置焦点监听
    _focusNodeUserPhone.addListener(_focusNodeListener);
    _focusNodePassWord.addListener(_focusNodeListener);
    //监听用户名框的输入改变
    _userPhoneController.addListener(() {
      print(_userPhoneController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    // 移除焦点监听
    _focusNodeUserPhone.removeListener(_focusNodeListener);
    _focusNodePassWord.removeListener(_focusNodeListener);
    _userPhoneController.dispose();
    super.dispose();
  }

  // 监听焦点
  Future<Null> _focusNodeListener() async {
    if (_focusNodeUserPhone.hasFocus) {
      print("用户名框获取焦点");
      // 取消密码框的焦点状态
      _focusNodePassWord.unfocus();
    }
    if (_focusNodePassWord.hasFocus) {
      print("密码框获取焦点");
      // 取消用户名框焦点状态
      _focusNodeUserPhone.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    //输入文本框区域
    Widget inputTextArea = Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Consumer<UserInfoProvider>(
        builder: (BuildContext context, notifier, child) {
          _userPhoneController.text = notifier.userInfo.userPhone;
          _userPhoneController.selection = TextSelection.fromPosition(
            TextPosition(
              affinity: TextAffinity.downstream,
              offset: '${_userPhoneController.text}'.length,
            ),
          );
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: _userPhoneController,
                  focusNode: _focusNodeUserPhone,
                  //设置键盘类型
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "请输入手机号",
                    prefixText: "+86 ",
                    prefixIcon: Icon(Icons.people),
                    //尾部添加清除按钮
                    suffixIcon: _userPhoneController.text.length > 0
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () => _userPhoneController.clear(),
                          )
                        : null,
                  ),
                  //验证用户名
                  validator: PhotoUtil.validatePhone,
                  //保存数据
                  onSaved: (String value) {
                    notifier.userInfo.userPhone = value;
                    notifier.saveUserInfo();
                  },
                ),
                TextFormField(
                  focusNode: _focusNodePassWord,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "请输入密码",
                      prefixIcon: Icon(Icons.lock),
                      // 是否显示密码
                      suffixIcon: IconButton(
                        icon: Icon((_isShowPwd) ? Icons.visibility : Icons.visibility_off),
                        // 点击改变显示或隐藏密码
                        onPressed: () {
                          setState(() {
                            _isShowPwd = !_isShowPwd;
                          });
                        },
                      )),
                  obscureText: !_isShowPwd,
                )
              ],
            ),
          );
        },
      ),
    );

    _loginOnPressed() async {
      //点击登录按钮，解除焦点，回收键盘
      _focusNodePassWord.unfocus();
      _focusNodeUserPhone.unfocus();

      if (_formKey.currentState.validate()) {
        //只有输入通过验证，才会执行这里
        _formKey.currentState.save();
        try {
          Response response = await Future.delayed(Duration(seconds: 2));
          PhotoUtil.alertDialog(
            context,
            "Success",
            "username: $response",
          );
          print("Server Success! username: $response");
        } catch (e) {
          PhotoUtil.alertDialog(
            context,
            "Fail",
            "signin failed",
          );
          print(e);
        }
      }
    }

    //忘记密码  立即注册
    Widget bottomArea = Container(
      margin: EdgeInsets.only(right: 50, left: 50),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            child: Text(
              "忘记密码?",
              style: TextStyle(
                color: Theme.of(context).accentColor,
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
                color: Theme.of(context).accentColor,
                fontSize: 16.0,
              ),
            ),
            //点击快速注册、执行事件
            onPressed: () async {
              await Navigator.pushNamed(context, SignUpPage.routeName);
            },
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      // 外层添加一个手势，用于点击空白部分，回收键盘
      body: GestureDetector(
        onTap: () {
          _focusNodePassWord.unfocus();
          _focusNodeUserPhone.unfocus();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              SizedBox(height: 50),
              logoImageArea(context),
              SizedBox(height: 30),
              inputTextArea,
              SizedBox(height: 50),
              button(context, "登录", _loginOnPressed),
              SizedBox(height: 20),
              bottomArea,
            ],
          ),
        ),
      ),
    );
  }
}
