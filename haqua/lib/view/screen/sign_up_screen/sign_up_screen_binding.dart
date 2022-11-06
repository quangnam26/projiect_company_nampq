

import 'package:get/get.dart';
import 'package:template/view/screen/sign_up_screen/sign_up_screen_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
