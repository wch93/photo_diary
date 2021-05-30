import 'package:photodiary/providers/user_info_provider.dart';

UserInfo data = UserInfo(
    userPhone: '13211111111',
    password: '111111',
    userName: 'testusername',
    avatarUrl:
        'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.qqju.com%2Fpic%2Ftx%2Ftx32743.jpg&refer=http%3A%2F%2Fwww.qqju.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1624953593&t=47627db1fdd168010a4b604b2cea1142');

Future<void> loginFunc(String userPhone, String pwd) async {
  if (pwd == data.password) {
    Future.delayed(Duration(seconds: 2));
    return {
      'status_code': 200,
      'login_success': true,
      'avatar_url': data.avatarUrl,
    };
  } else {
    Future.delayed(Duration(seconds: 2));
    return {
      'status_code': 200,
      'login_success': false,
    };
  }
}

Future<void> singUpFunc(String userPhone, String verificationCode) async {
  String correctVerificationCode = '123456';
  if (verificationCode == correctVerificationCode) {
    Future.delayed(Duration(seconds: 2));
    return {
      'status_code': 200,
      'signup_success': true,
      'avatar_url': data.avatarUrl,
    };
  } else {
    Future.delayed(Duration(seconds: 2));
    return {
      'status_code': 200,
      'signup_success': false,
    };
  }
}
