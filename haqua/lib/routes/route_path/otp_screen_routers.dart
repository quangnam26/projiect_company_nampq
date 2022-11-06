

import 'package:get/get.dart';
import 'package:template/view/screen/otp_screen/otp_screen_binding.dart';
import 'package:template/view/screen/otp_screen/otp_screen_page.dart';

class OTPScreenRoutes {
  static const String OTP_SCREEN = '/otp_screen';

  static List<GetPage> list = [
    GetPage(
      name: OTP_SCREEN,
      page: () => OTPScreenPage(),
      binding: OTPScreenBinding(),
    ),
  ];
}