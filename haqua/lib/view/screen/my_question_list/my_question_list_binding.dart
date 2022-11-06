

import 'package:get/get.dart';
import 'package:template/view/screen/my_question_list/my_question_list_controller.dart';

class MyQuestionListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyQuestionListController>(() => MyQuestionListController());
  }
}