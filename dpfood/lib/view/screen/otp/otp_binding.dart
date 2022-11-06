import 'package:get/get.dart';
import 'package:template/view/screen/otp/otp_controller.dart';

class OTPBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<OTPController>(OTPController());
  }
}