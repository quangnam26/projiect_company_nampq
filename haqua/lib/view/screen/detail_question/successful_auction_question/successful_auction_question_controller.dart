import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/home_routers.dart';
import 'package:template/view/screen/home/home_controller.dart';

class SuccessfulAuctionQuestionController extends GetxController {
  ///
  /// onGoToHomePage
  ///
  void onGoToHomePage() {
    Get.find<HomeController>().getCountNotice();
    Get.offAllNamed(HomeRoutes.DASHBOARD, predicate: ModalRoute.withName(HomeRoutes.DASHBOARD));
  }
}
