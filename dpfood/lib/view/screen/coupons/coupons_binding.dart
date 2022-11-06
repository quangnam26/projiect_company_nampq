

import 'package:get/get.dart';
import 'package:template/view/screen/coupons/coupons_controller.dart';

class CouponsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CouponsController>(() => CouponsController());
  }
}