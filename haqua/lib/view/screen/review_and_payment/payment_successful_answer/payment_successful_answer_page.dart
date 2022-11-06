import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_successful_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/review_and_payment/payment_successful_answer/payment_successful_answer_controller.dart';

class PaymentSuccessfulAnswerPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder(
        init: PaymentSuccessfulAnswerController(),
        builder: (PaymentSuccessfulAnswerController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return IZISuccessfulScreen(
            labelAppBar: "Notify".tr,
            title: "thanh_cong".tr,
            labelButton: "Complete".tr,
            onTap: () {
              controller.goToDashBoard();
            },
            typeButton: IZIButtonType.OUTLINE,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AvatarGlow(
                      glowColor: ColorResources.SUCCESSFUL_PAGE,
                      endRadius: IZIDimensions.iziSize.width * .4,
                      repeatPauseDuration: const Duration(milliseconds: 50),
                      child: ClipOval(
                        child: Container(
                          width: IZIDimensions.iziSize.width * .37,
                          height: IZIDimensions.iziSize.width * .37,
                          color: ColorResources.SUCCESSFUL_PAGE,
                          child: Center(
                            child: Icon(
                              Icons.done_rounded,
                              size: IZIDimensions.ONE_UNIT_SIZE * 150,
                              color: ColorResources.WHITE,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                    IZIDimensions.ONE_UNIT_SIZE * 50,
                    0,
                    IZIDimensions.ONE_UNIT_SIZE * 50,
                    IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "thanh_cong".tr,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                    IZIDimensions.ONE_UNIT_SIZE * 50,
                    0,
                    IZIDimensions.ONE_UNIT_SIZE * 50,
                    IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: Text(
                    'payment_success_1'.tr,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      color: ColorResources.BLACK,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                    IZIDimensions.ONE_UNIT_SIZE * 20,
                    0,
                    IZIDimensions.ONE_UNIT_SIZE * 20,
                    IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: Text(
                    "payment_success_2".tr,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      color: ColorResources.BLACK,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (controller.isMore == false)
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.onChangeIsMore();
                          },
                          child: Text(
                            "payment_success_3".tr,
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              color: ColorResources.CALL_VIDEO,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (controller.isMore == true)
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      IZIDimensions.ONE_UNIT_SIZE * 20,
                      0,
                      IZIDimensions.ONE_UNIT_SIZE * 20,
                      IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: Text(
                      "payment_success_4".tr,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        color: ColorResources.BLACK,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (controller.isMore == true)
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      IZIDimensions.ONE_UNIT_SIZE * 20,
                      0,
                      IZIDimensions.ONE_UNIT_SIZE * 20,
                      IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          child: Text(
                            "payment_success_5".tr,
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          child: Text(
                            "payment_success_6".tr,
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              color: ColorResources.BLACK,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IZIImage(
                                ImagesPath.image_share_video,
                                width: IZIDimensions.iziSize.width * .6,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_5X,
                          ),
                          child: Text(
                            "payment_success_7".tr,
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              color: ColorResources.BLACK,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_5X,
                          ),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: "payment_success_8".tr,
                                  style: const TextStyle(
                                    color: ColorResources.BLACK,
                                  ),
                                ),
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.goToDetailQuestion();
                                    },
                                    child: Text(
                                      "payment_success_9".tr,
                                      style: TextStyle(
                                        color: ColorResources.CALL_VIDEO,
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.onChangeIsMore();
                                },
                                child: Text(
                                  "payment_success_10".tr,
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    color: ColorResources.CALL_VIDEO,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
