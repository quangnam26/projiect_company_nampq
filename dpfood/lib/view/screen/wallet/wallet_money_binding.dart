import 'package:get/get.dart';
import 'package:template/view/screen/wallet/wallet_money_controller.dart';

class V2WalletMoneyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<V2WalletMoneyController>(V2WalletMoneyController());
  }
}
