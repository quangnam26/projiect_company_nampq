import 'package:get/get.dart';
import 'package:template/view/screen/thank_you_screen/thank_you_screen_controller.dart';

class ThankYouBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThankYouController>(() => ThankYouController());
  }
}
