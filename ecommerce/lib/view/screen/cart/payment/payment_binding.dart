import 'package:get/get.dart';
import 'package:template/view/screen/cart/payment/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PaymentController>(PaymentController());
  }
}
