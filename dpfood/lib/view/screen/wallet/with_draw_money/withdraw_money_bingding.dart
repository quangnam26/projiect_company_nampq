import 'package:get/get.dart';
import 'package:template/view/screen/wallet/with_draw_money/withdraw_money_controller.dart';

class WithDrawMoneyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithDrawMoneyController>(
      () => WithDrawMoneyController(),
    );
  }
}
