import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_otp.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/view/screen/otp_screen/otp_screen_controller.dart';

import '../../../utils/color_resources.dart';

class OTPScreenPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OTPScreenController(),
      builder: (OTPScreenController controller) {
        if (controller.isLoading) {
          return Center(
            child: IZILoading().isLoadingKit,
          );
        }
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: Container(
              color: ColorResources.BACKGROUND,
              width: IZIDimensions.iziSize.width,
              height: IZIDimensions.iziSize.height,
              child: Center(
                child: Obx(
                  () => IZIOtp(
                    countDown: 30,
                    onTapSendSMS: () {
                      controller.getOTP();
                    },
                    lables: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          0,
                          IZIDimensions.ONE_UNIT_SIZE * 50,
                          0,
                          IZIDimensions.SPACE_SIZE_3X,
                        ),
                        child: Text(
                          "account_verification".tr,
                          style: TextStyle(
                            color: ColorResources.RED,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "verification_code".tr,
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    isEnabled: controller.isEnabledButton.value,
                    onTap: () {
                      controller.goToAreasOfExpertisePage();
                    },
                    colorSMS: ColorResources.PRIMARY_APP,
                    buttonLabel: "continue".tr,
                    onChanged: (val) {
                      controller.onChangedOTPCode(val!);
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
