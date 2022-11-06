import 'package:get/get.dart';
import 'package:template/view/screen/order/reviewer_order/reviewer_order_controller.dart';

class ReviewerOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewerOrderController>(() => ReviewerOrderController());
  }
}
