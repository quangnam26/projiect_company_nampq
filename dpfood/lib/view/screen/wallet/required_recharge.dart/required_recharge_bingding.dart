import 'package:get/get.dart';
import 'package:template/view/screen/wallet/required_recharge.dart/required_recharge_controller.dart';



class RequiredRechargeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequiredRechargeController>(
      () => RequiredRechargeController(),
    );
  }
}
