import 'package:get/get.dart';
import 'package:template/view/screen/auth/forget_password/forget_password_controller.dart';

class ForgetPassWordBingding extends Bindings{
  @override
  void dependencies() {
    Get.put<ForgetPasswordController>(ForgetPasswordController(),permanent: true);
  }
}