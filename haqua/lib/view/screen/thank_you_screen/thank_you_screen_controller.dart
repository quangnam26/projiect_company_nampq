import 'package:get/get.dart';
import 'package:template/routes/route_path/ready_routers.dart';

class ThankYouController extends GetxController {
  ///
  /// Go to [Ready Page].
  ///
  void goToReadyPage() {
    Get.toNamed(ReadyScreenRoutes.READY_SCREEN);
  }
}
