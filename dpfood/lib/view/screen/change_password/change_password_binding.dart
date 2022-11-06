import 'package:get/get.dart';
import 'package:template/view/screen/change_password/change_password_controller.dart';

class ChangePassWordBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<ChangePassWordController>(ChangePassWordController());
  }
}