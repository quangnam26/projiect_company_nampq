

import 'package:get/get.dart';
import 'package:template/view/screen/auth/verify/verify_otp_controller.dart';

class VerifyOtpBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<VerifyOtpController>(VerifyOtpController());
  }
}