

import 'package:get/get.dart';
import 'package:template/view/screen/detail_question/successful_auction_question/successful_auction_question_binding.dart';
import 'package:template/view/screen/detail_question/successful_auction_question/successful_auction_question_page.dart';


class IZISuccessfulRoutes {
  static const String IZI_SUCCESSFUL = '/izi_successful';

  static List<GetPage> list = [
    GetPage(
      name: IZI_SUCCESSFUL,
      page: () => SuccessfulAuctionQuestionPage(),
      binding: SuccessfulAuctionQuestionBinding(),
    ),
  ];
}