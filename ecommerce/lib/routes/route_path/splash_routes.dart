import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/view/screen/auth/forget_password/forget_password_bingding.dart';
import 'package:template/view/screen/auth/forget_password/forget_password_page.dart';
import 'package:template/view/screen/auth/login/login_bingding.dart';
import 'package:template/view/screen/auth/login/login_page.dart';
import 'package:template/view/screen/auth/register/register_bingding.dart';
import 'package:template/view/screen/auth/register/register_page.dart';
import 'package:template/view/screen/introduction/introduction_bingding.dart';
import 'package:template/view/screen/introduction/introduction_page.dart';
import 'package:template/view/screen/splash/splash_bingding.dart';
import 'package:template/view/screen/splash/splash_page.dart';
// import 'package:template/view/screen/splash/splash_binding.dart';

import '../../view/screen/dash_board/dash_board_binding.dart';
import '../../view/screen/dash_board/dash_board_page.dart';
// import '../../view/screen/onboarding/onboarding_binding.dart';

// ignore: avoid_classes_with_only_static_members
class SplashRoutes {
  static const String SPLASH = '/splash';
  static const String INTRODUCTION = '/introduction';
  static const String STATE = '/state';
  static const String VEHICLE = '/vehicle';
  static const String HOME = '/home';
  static const String LOGIN = '/login';
  static const String FORGET_PASSWORD = '/forget_password';
  static const String REGISTER = '/register';

  static List<GetPage> list = [
    GetPage(
      name: SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: HOME,
      page: () => DashBoardPage(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: FORGET_PASSWORD,
      page: () => ForgetPasswordPage(),
      binding: ForgetPassWordBingding(),
    ),

    GetPage(
      name: REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBingding(),
    ),
       GetPage(
      name: INTRODUCTION,
      page: () => IntroductionPage(),
      binding: IntroductionBinding(),
    )
  ];
}
