import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/home_routers.dart';

class ShareVideoSuccessfullyController extends GetxController {
  ///
  /// goToDashBoard
  ///
  void goToDashBoard() {
    Get.offAllNamed(HomeRoutes.DASHBOARD, predicate: ModalRoute.withName(HomeRoutes.DASHBOARD));
  }
}
