import 'package:get/get.dart';
import 'package:template/view/screen/your_abilities/your_abilities_controller.dart';

class YourAbilitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YourAbilitiesController>(
      () => YourAbilitiesController(),
    );
  }
}
