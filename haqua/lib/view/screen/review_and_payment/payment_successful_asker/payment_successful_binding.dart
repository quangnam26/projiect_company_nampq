import 'package:get/get.dart';
import 'package:template/view/screen/review_and_payment/payment_successful_asker/payment_successful_asker_controller.dart';

class PaymentSuccessfulAskerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentSuccessfulAskerController>(() => PaymentSuccessfulAskerController());
  }
}
