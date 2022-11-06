import 'package:get/get.dart';
import 'package:template/view/screen/account_user/change_language/change_language_controller.dart';

class ChangeLanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeLanguageController>(() => ChangeLanguageController());
  }
}
