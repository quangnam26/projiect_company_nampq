import 'package:get/get.dart';
import 'package:template/view/screen/accounts/change_the_password/change_the_password_controller.dart';

class ChangeThePassWordBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ChangeThePassWordController>(()=> ChangeThePassWordController());
  }
}