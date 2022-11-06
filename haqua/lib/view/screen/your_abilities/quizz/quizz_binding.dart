import 'package:get/get.dart';
import 'package:template/view/screen/your_abilities/quizz/quizz_controller.dart';

class QuizzBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizzController>(
      () => QuizzController(),
    );
  }
}
