import 'package:photodiary/pages/new_photo.dart';
import 'package:photodiary/pages/sign_in.dart';
import 'package:photodiary/pages/sign_up.dart';
import 'package:photodiary/util/const.dart';

final routes = {
  RoutesName.signInPage: (context) => SignInPage(),
  RoutesName.signUpPage: (context) => SignUpPage(),
  RoutesName.newPhotoPage: (context) => NewPhotoPage(),
};
