

import 'package:get/get.dart';
import 'package:template/view/screen/login_screen/login_screen_binding.dart';
import 'package:template/view/screen/login_screen/login_screen_page.dart';

import '../../view/screen/forgot_password/forgot_password_binding.dart';
import '../../view/screen/forgot_password/forgot_password_page.dart';

class LoginRoutes {
  static const String LOGIN = '/login';
  static const String FORGOT_PASS = '/forgot_pass';

  static List<GetPage> list = [
    GetPage(
      name: LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: FORGOT_PASS,
      page: () => ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
  ];
}