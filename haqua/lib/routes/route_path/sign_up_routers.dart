import 'package:get/get.dart';
import 'package:template/view/screen/sign_up_screen/sign_up_screen_binding.dart';
import 'package:template/view/screen/sign_up_screen/sign_up_screen_page.dart';

class SignUpRoutes {
  static const String SIGN_UP = '/sign_up';

  static List<GetPage> list = [
    GetPage(
      name: SIGN_UP,
      page: () => SignUpPage(),
      binding: SignUpBinding(),
    ),
  ];
}
