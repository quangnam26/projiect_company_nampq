import 'package:get/get.dart';
import 'package:template/view/screen/account_user/account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(() => AccountController());
  }
}
