import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/routes/route_path/home_routers.dart';

import '../../../home/home_controller.dart';

class NotifyShareController extends GetxController {
//Khai bao data
  String? moneyShare;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  ///
  /// getArgument
  ///
  void getArgument() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      moneyShare = Get.arguments.toString();
    }
    isLoading = false;
    update();
  }

  ///
  /// doneAndGoToDashboard
  ///
  void doneAndGoToDashboard() {
    Get.find<HomeController>().getCountNotice();
    Get.offAllNamed(HomeRoutes.DASHBOARD, predicate: ModalRoute.withName(HomeRoutes.DASHBOARD));
  }
}
