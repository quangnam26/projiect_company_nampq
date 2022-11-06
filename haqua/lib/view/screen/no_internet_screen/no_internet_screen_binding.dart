import 'package:get/get.dart';
import 'package:template/view/screen/no_internet_screen/no_internet_screen_controller.dart';

class NoInternetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoInternetController>(() => NoInternetController());
  }
}
