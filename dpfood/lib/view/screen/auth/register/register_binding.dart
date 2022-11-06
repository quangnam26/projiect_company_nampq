

import 'package:get/get.dart';
import 'package:template/view/screen/auth/register/register_controller.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController(),permanent: true);
  }
}