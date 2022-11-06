import 'package:get/get.dart';
import 'package:template/view/screen/wallet/recharge_money/recharge_money_controller.dart';



class RechargeMoneyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RechargeMoneyController>(
      () => RechargeMoneyController(),
    );
  }
}
