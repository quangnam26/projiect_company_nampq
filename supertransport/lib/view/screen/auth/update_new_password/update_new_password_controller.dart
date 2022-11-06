import 'package:get/get.dart';
import 'package:template/routes/route_path/auth_routes.dart';

class UpdateNewPasswordController extends GetxController {
  

  void onBack() {
    Get.back();
  }

  ///
  /// on update password button
  ///
  void onUpdateNewPassword(){
    Get.toNamed(AuthRoutes.FORGET_PASSWORD);
  }

}
