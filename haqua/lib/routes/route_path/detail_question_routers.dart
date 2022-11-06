

import 'package:get/get.dart';
import 'package:template/view/screen/detail_question/detail_question_binding.dart';
import 'package:template/view/screen/detail_question/detail_question_page.dart';

class DetailQuestionRoutes {
  static const String DETAIL_QUESTION = '/detail_question';


  static List<GetPage> list = [
    GetPage(
      name: DETAIL_QUESTION,
      page: () => DetailQuestionPage(),
      binding: DetailQuestionBinding(),
    ),

  ];
}