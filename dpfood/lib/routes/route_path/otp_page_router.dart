import 'package:get/get.dart';
import 'package:template/view/screen/otp/otp_binding.dart';
import 'package:template/view/screen/otp/otp_page.dart';
import 'package:template/view/screen/otp/phone/phone_binding.dart';
import 'package:template/view/screen/otp/phone/phone_page.dart';
// ignore: avoid_classes_with_only_static_members
class OTPPageRoutes {


  static const String OTP = '/otp';
  static const String OTPPHONE = '/otp_phone';
  static List<GetPage> list = [
    
    GetPage(
      name: OTP,
      page: () => OTPPage(),
      binding: OTPBinding(),
    ),
      GetPage(
      name: OTPPHONE,
      page: () => OTPPhonePage(),
      binding: OTPPhoneBinding(),
    ),
   
  ];
}
