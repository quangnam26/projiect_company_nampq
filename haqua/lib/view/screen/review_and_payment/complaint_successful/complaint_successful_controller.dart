import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/home_routers.dart';

import '../../home/home_controller.dart';

class ComplaintSuccessfulController extends GetxController {
  ///
  /// goToDashBoard
  ///
  void goToDashBoard() {
    Get.find<HomeController>().getCountNotice();
    Get.offAllNamed(HomeRoutes.DASHBOARD, predicate: ModalRoute.withName(HomeRoutes.DASHBOARD));
  }
}
