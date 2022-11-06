

import 'package:get/get.dart';
import 'package:template/view/screen/status_order/status_order_controller.dart';

class StatusOrderBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<StatusOrderController>(() => StatusOrderController());
  }
}