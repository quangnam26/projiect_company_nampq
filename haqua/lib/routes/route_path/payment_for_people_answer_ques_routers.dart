

import 'package:get/get.dart';
import 'package:template/view/screen/payment_for_people_answer_ques/payment_for_people_answer_ques_binding.dart';
import 'package:template/view/screen/payment_for_people_answer_ques/payment_for_people_answer_ques_page.dart';

class PaymentForPeppleAnswerQuesListRoutes {
  static const String PAYMENT_FOR_PEOPLE_ANSWER_QUES = '/payment_for_people_answer_ques';

  static List<GetPage> list = [
    GetPage(
      name: PAYMENT_FOR_PEOPLE_ANSWER_QUES,
      page: () => PaymentForPeopleAnswerQuesPage(),
      binding: PaymentForPeopleAnswerQuesBinding(),
    ),
  ];
}