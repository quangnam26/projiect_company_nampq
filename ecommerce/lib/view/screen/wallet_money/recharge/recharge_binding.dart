import 'package:get/get.dart';
import 'package:template/view/screen/wallet_money/recharge/recharge_controller.dart';

class ReChargeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ReChargeController>(ReChargeController());
  }
}
