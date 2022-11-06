import 'package:get/get.dart';
import 'package:template/routes/route_path/home_routers.dart';

class ReadyScreenController extends GetxController {


  ///
  /// Go to [Home page].
  ///
  void goToDashboard() {
    Get.offAllNamed(HomeRoutes.DASHBOARD);
  }
}
