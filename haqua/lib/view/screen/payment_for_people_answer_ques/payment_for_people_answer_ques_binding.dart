import 'package:get/get.dart';
import 'package:template/view/screen/payment_for_people_answer_ques/payment_for_people_answer_ques_controller.dart';

class PaymentForPeopleAnswerQuesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentForPeopleAnswerQuesController>(() => PaymentForPeopleAnswerQuesController());
  }
}
