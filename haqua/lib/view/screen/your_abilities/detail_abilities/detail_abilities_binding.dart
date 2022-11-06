import 'package:get/get.dart';
import 'package:template/view/screen/your_abilities/detail_abilities/detail_abilities_controller.dart';

class DetailAbilitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailAbilitiesController>(
      () => DetailAbilitiesController(),
    );
  }
}
