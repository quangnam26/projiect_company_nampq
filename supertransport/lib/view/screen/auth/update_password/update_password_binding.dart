

import 'package:get/get.dart';
import 'package:template/view/screen/auth/update_password/update_password_controller.dart';

class UpdatePasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<UpdatePasswordController>(UpdatePasswordController());
  }
}