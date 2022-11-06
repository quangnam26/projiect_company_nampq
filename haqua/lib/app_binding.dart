import 'package:get/get.dart';
import 'package:template/view/screen/splash/splash_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
