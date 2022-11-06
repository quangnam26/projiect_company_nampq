import 'package:get/get.dart';
import 'package:template/view/screen/create_question/create_question_controller.dart';

class CreateQuestionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CreateQuestionController>(() => CreateQuestionController());
  }
}