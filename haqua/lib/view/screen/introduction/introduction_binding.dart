


import 'package:get/get.dart';
import 'package:template/view/screen/introduction/introduction_controller.dart';

class IntroductionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroductionController>(() => IntroductionController());
  }
}
