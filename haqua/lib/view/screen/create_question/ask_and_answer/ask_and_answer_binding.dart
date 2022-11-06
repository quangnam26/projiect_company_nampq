

import 'package:get/get.dart';
import 'package:template/view/screen/create_question/ask_and_answer/ask_and_answer_controller.dart';

class AskAndAnswerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AskAndAnswerController>(() => AskAndAnswerController());
  }
}