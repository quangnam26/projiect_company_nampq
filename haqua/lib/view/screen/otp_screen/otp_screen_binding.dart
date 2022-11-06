import 'package:get/get.dart';
import 'package:template/view/screen/otp_screen/otp_screen_controller.dart';

class OTPScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OTPScreenController>(() => OTPScreenController());
  }
}
