


import 'package:get/get.dart';
import 'package:template/view/screen/review_and_payment/review_and_payment_controller.dart';

class ReviewAndPaymentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ReviewAndPaymentController>(() => ReviewAndPaymentController());
  }
}