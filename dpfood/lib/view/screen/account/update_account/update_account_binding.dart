

import 'package:get/get.dart';
import 'package:template/view/screen/account/update_account/update_account_controller.dart';

class UpdateAccountBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UpdateAccountController>(()=> UpdateAccountController());
  }
}