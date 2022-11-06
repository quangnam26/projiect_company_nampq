

import 'package:get/get.dart';
import 'package:template/view/screen/detail_question/detail_question_controller.dart';

class DetailQuestionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DetailQuestionController>(() => DetailQuestionController());
  }
}