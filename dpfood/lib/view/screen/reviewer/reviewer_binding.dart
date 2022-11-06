
import 'package:get/get.dart';
import 'package:template/view/screen/reviewer/reviewer_controller.dart';

class ReviewerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ReviewerController>(() => ReviewerController());
  }
}