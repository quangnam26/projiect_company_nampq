import 'package:get/get.dart';
import 'package:template/view/screen/sign_up_and_sign_in/sign_up_and_sign_in_controller.dart';

class SignUpAndSignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpAndSignInController>(() => SignUpAndSignInController());
  }
}
