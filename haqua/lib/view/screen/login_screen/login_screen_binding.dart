import 'package:get/get.dart';
import 'package:template/view/screen/login_screen/login_screen_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
