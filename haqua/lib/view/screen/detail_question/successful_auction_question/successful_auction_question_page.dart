import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_successful_screen.dart';
import 'package:template/view/screen/detail_question/successful_auction_question/successful_auction_question_controller.dart';

class SuccessfulAuctionQuestionPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder(
          init: SuccessfulAuctionQuestionController(),
          builder: (SuccessfulAuctionQuestionController controller) {
            return IZISuccessfulScreen(
              labelAppBar: "Notify".tr,
              title: "Successful_auction".tr,
              description: "submitted_successfully".tr,
              labelButton: "Complete".tr,
              onTap: () {
                controller.onGoToHomePage();
              },
              typeButton: IZIButtonType.DEFAULT,
            );
          }),
    );
  }
}
