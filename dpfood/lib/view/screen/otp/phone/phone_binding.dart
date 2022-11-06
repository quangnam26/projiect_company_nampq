import 'package:get/get.dart';
import 'package:template/view/screen/otp/phone/phone_controller.dart';

class OTPPhoneBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<OTPPhoneController>(OTPPhoneController());
  }
}