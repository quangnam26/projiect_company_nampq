import 'package:get/get.dart';
import 'package:template/view/screen/personal/personal_controller.dart';

class PersonalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PersonalController>(PersonalController());
  }
}
