import 'package:get/get.dart';
import 'package:template/view/screen/home/home_controller.dart';

class HomeBingding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
