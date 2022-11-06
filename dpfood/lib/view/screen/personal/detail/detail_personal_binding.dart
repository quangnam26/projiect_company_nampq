import 'package:get/get.dart';
import 'package:template/view/screen/personal/detail/detail_personal_controller.dart';

class DetailPersonalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DetailPersonalController>(DetailPersonalController());
  }
}
