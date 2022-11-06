import 'package:get/get.dart';
import 'package:template/view/screen/review_and_payment/payment_successful_answer/payment_successful_answer_controller.dart';

class PaymentSuccessfulAnswerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentSuccessfulAnswerController>(() => PaymentSuccessfulAnswerController());
  }
}
