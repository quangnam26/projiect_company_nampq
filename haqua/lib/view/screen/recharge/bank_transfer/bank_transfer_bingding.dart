import 'package:get/get.dart';
import 'package:template/view/screen/recharge/bank_transfer/bank_transfer_controller.dart';

class BankTransferBingding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankTransferPageController>(
      () => BankTransferPageController(),
    );
  }
}
