import 'package:get/get.dart';
import 'package:template/view/screen/withdrawmoney.dart/withdraw_money_controller.dart';

class WithDrawMoneyBingding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithDrawMoneyController>(
      () => WithDrawMoneyController(),
    );
  }
}
