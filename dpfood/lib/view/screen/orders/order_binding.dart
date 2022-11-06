

import 'package:get/get.dart';
import 'package:template/view/screen/orders/order_controller.dart';

class OrderBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController());
  }
}