import 'package:get/get.dart';
import 'package:template/view/screen/ready_screen/ready_screen_controller.dart';

class ReadyScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadyScreenController>(() => ReadyScreenController());
  }
}
