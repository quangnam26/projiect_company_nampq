import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/routes/route_path/home_routers.dart';
import 'package:template/routes/route_path/quotation_routers.dart';

import '../../home/home_controller.dart';

class PaymentSuccessfulAnswerController extends GetxController {
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
      idQuestion = Get.arguments['idQuestion'].toString();
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
    Get.toNamed(QuotationRoutes.DETAILQUOTATIONITEM, arguments: idQuestion);
  }

  ///
  /// goToDashBoard
  ///
  void goToDashBoard() {
    Get.find<HomeController>().getCountNotice();
    Get.offAllNamed(HomeRoutes.DASHBOARD, predicate: ModalRoute.withName(HomeRoutes.DASHBOARD));
  }
}
