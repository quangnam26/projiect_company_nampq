

import 'package:get/get.dart';
import 'package:template/view/screen/detail_question/successful_auction_question/successful_auction_question_controller.dart';

class SuccessfulAuctionQuestionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SuccessfulAuctionQuestionController>(() => SuccessfulAuctionQuestionController());
  }
}