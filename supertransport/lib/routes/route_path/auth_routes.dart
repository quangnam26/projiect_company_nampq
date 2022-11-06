import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../view/screen/auth/forget_password/forget_password_binding.dart';
import '../../view/screen/auth/forget_password/forget_password_page.dart';
import '../../view/screen/auth/login/login_binding.dart';
import '../../view/screen/auth/login/login_page.dart';
import '../../view/screen/auth/register/register_binding.dart';
import '../../view/screen/auth/register/register_page.dart';
import '../../view/screen/auth/update_password/update_password_binding.dart';
import '../../view/screen/auth/update_password/update_password_page.dart';
import '../../view/screen/auth/verify/verify_otp_binding.dart';
import '../../view/screen/auth/verify/verify_otp_page.dart';

// ignore: avoid_classes_with_only_static_members
class AuthRoutes {
  static const String LOGIN = '/login';
  static const String FORGET_PASSWORD = '/forget_password';
  static const String UPDATE_PASSWORD = '/update_password';
  static const String REGISTER = '/register';
  static const String VERIFY = '/verify';

  static List<GetPage> list = [
    GetPage(
      name: LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: FORGET_PASSWORD,
      page: () => ForgetPasswordPage(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: UPDATE_PASSWORD,
      page: () => UpdatePasswordPage(),
      binding: UpdatePasswordBinding(),
    ),
    GetPage(
      name: REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: VERIFY,
      page: () => VerifyOtpPage(),
      binding: VerifyOtpBinding(),
    ),
    
  ];
}
