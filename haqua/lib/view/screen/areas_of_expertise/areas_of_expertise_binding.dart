import 'package:get/get.dart';
import 'package:template/view/screen/areas_of_expertise/areas_of_expertise_controller.dart';

class AreasOfExpertiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AreasOfExpertiseController>(() => AreasOfExpertiseController());
  }
}
