import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/routes/route_path/help_wating_list_routers.dart';
import 'package:template/routes/route_path/home_routers.dart';
import 'package:template/view/screen/help_wating_list/help_wating_list_controller.dart';

import '../../home/home_controller.dart';

class PaymentSuccessfulAskerController extends GetxController {
  //Khai bao data
  bool isMore = false;
  bool isLoading = true;
  String? idQuestion;

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
      idQuestion = Get.arguments.toString();
      print("idQuestion $idQuestion");
    }
    isLoading = false;
    update();
  }

  ///
  ///onChangeIsMore
  ///
  void onChangeIsMore() {
    isMore = !isMore;
    update();
  }

  ///
  /// goToDetailQuestion
  ///
  void goToDetailQuestion() {
    print("Help idQuestion $idQuestion");
    Get.find<HelpWatingListController>().getDetailQuestionByIdResetStatus();
    Get.toNamed(HelpWatingListRoutes.HELP_WATING_LIST, arguments: idQuestion);
  }

  ///
  /// goToDashBoard
  ///
  void goToDashBoard() {
    Get.find<HomeController>().getCountNotice();
    Get.offAllNamed(HomeRoutes.DASHBOARD, predicate: ModalRoute.withName(HomeRoutes.DASHBOARD));
  }
}
