

import 'package:get/get.dart';
import 'package:template/view/screen/accounts/account_controller.dart';


class AccountBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<AccountController>(AccountController());
  }
}