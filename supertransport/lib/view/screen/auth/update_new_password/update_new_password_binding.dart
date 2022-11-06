

import 'package:get/get.dart';
import 'package:template/view/screen/auth/update_new_password/update_new_password_controller.dart';

class UpdateNewPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<UpdateNewPasswordController>(UpdateNewPasswordController());
  }
}