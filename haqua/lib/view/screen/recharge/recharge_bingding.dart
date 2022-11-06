
import 'package:get/get.dart';
import 'package:template/view/screen/recharge/recharge_controller.dart';

class RechargeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RechargeController>(() => RechargeController());
  }
}
