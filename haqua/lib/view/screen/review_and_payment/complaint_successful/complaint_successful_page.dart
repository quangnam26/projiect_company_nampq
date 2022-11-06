import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_successful_screen.dart';
import 'package:template/view/screen/review_and_payment/complaint_successful/complaint_successful_controller.dart';

class ComplaintSuccessfulPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder(
        init: ComplaintSuccessfulController(),
        builder: (ComplaintSuccessfulController controller) {
          return IZISuccessfulScreen(
            labelAppBar: "Notify".tr,
            title: "review_page_8".tr,
            description: "payment_success_11".tr,
            labelButton: "Complete",
            onTap: () {
              controller.goToDashBoard();
            },
            typeButton: IZIButtonType.OUTLINE,
          );
        },
      ),
    );
  }
}
