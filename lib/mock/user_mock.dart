import 'package:photodiary/providers/user_info_provider.dart';

UserInfo data = UserInfo(
    userPhone: '13211111111',
    password: '111111',
    userName: 'Tester Name',
    avatarUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMu0G_mCSgYuGIdehCW9XMRPVPYEg3wnJ2S1E_u3ILnOOgrJ4d43iLarUTOBPr5uDY_aI&usqp=CAU');

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
