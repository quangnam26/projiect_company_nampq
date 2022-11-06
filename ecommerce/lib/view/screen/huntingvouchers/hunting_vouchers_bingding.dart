import 'package:get/get.dart';
import 'package:template/view/screen/huntingvouchers/hunting_vouchers_controller.dart';

class HuntingVouchersBingding extends Bindings{
  @override
  void dependencies() {
    Get.put<HuntingVouchersController>(HuntingVouchersController(),permanent: true);
  }
}