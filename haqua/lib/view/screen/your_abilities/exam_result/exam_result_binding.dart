import 'package:get/get.dart';
import 'package:template/view/screen/your_abilities/exam_result/exam_result_controller.dart';

class ExamResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExamResultController>(
      () => ExamResultController(),
    );
  }
}
