import 'package:get/get.dart';
import 'package:template/view/screen/account_user/infor_account/infor_account_controller.dart';

class InforAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InforAccountController>(() => InforAccountController());
  }
}
