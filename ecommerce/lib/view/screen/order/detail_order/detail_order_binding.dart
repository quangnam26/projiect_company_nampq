import 'package:get/get.dart';
import 'package:template/view/screen/order/order_controller.dart';

class DetailOrderBingding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController());
  }
}
