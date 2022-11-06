import 'package:get/get.dart';
import 'package:template/view/screen/review_and_payment/complaint_successful/complaint_successful_binding.dart';
import 'package:template/view/screen/review_and_payment/complaint_successful/complaint_successful_page.dart';
import 'package:template/view/screen/review_and_payment/payment_successful_answer/payment_successful_answer_binding.dart';
import 'package:template/view/screen/review_and_payment/payment_successful_answer/payment_successful_answer_page.dart';
import 'package:template/view/screen/review_and_payment/payment_successful_asker/payment_successful_asker_page.dart';
import 'package:template/view/screen/review_and_payment/payment_successful_asker/payment_successful_binding.dart';
import 'package:template/view/screen/review_and_payment/review_and_payment_binding.dart';
import 'package:template/view/screen/review_and_payment/review_and_payment_page.dart';

class ReviewAndPaymentRoutes {
  static const String REVIEW_AND_PAYMENT = '/review_and_payment';
  static const String COMPLAINT_SUCCESSFUL = '/complaint_successful';
  static const String PAYMENT_SUCCESSFUL_ASKER = '/paymnet_successful_asker';
  static const String PAYMENT_SUCCESSFUL_ANSWER = '/paymnet_successful_answer';

  static List<GetPage> list = [
    GetPage(
      name: REVIEW_AND_PAYMENT,
      page: () => ReviewAndPaymentPage(),
      binding: ReviewAndPaymentBinding(),
    ),
    GetPage(
      name: COMPLAINT_SUCCESSFUL,
      page: () => ComplaintSuccessfulPage(),
      binding: ComplaintSuccessfulBinding(),
    ),
    GetPage(
      name: PAYMENT_SUCCESSFUL_ASKER,
      page: () => PaymentSuccessfulAskerPage(),
      binding: PaymentSuccessfulAskerBinding(),
    ),
    GetPage(
      name: PAYMENT_SUCCESSFUL_ANSWER,
      page: () => PaymentSuccessfulAnswerPage(),
      binding: PaymentSuccessfulAnswerBinding(),
    ),
  ];
}
