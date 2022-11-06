
import 'package:get/get.dart';
import 'package:template/view/screen/cart/choosevoucher/choose_voucher_controller.dart';

class ChooseVoucherBingding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChooseVoucherController>(ChooseVoucherController());
  }
}