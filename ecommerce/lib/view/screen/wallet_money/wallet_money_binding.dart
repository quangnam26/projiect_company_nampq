import 'package:get/get.dart';
import 'package:template/view/screen/wallet_money/wallet_money_controller.dart';

class WalletMoneyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WalletMoneyController>(WalletMoneyController());
  }
}
