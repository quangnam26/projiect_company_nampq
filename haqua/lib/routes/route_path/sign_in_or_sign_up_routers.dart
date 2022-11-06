import 'package:get/get.dart';
import 'package:template/view/screen/sign_up_and_sign_in/sign_up_and_sign_in_binding.dart';
import 'package:template/view/screen/sign_up_and_sign_in/sign_up_and_sign_in_page.dart';

class SignInOrSignUpRoutes {
  static const String SIGN_IN_OR_SIGN_UP = '/sign_in_or_sign_up';

  static List<GetPage> list = [
    GetPage(
      name: SIGN_IN_OR_SIGN_UP,
      page: () => SignUpAndSignInPage(),
      binding: SignUpAndSignInBinding(),
    ),
  ];
}
