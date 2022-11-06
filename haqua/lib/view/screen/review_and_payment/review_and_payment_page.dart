import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_drop_down_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/review_and_payment/review_and_payment_controller.dart';

class ReviewAndPaymentPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: ColorResources.BACKGROUND,
          appBar: AppBar(
            backgroundColor: ColorResources.BACKGROUND,
            elevation: 0,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: ColorResources.BLACK,
              ),
            ),
            title: Text(
              "review_page_1".tr,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: IZIDimensions.FONT_SIZE_H6,
                color: ColorResources.BLACK,
              ),
            ),
          ),
          body: GetBuilder(
            init: ReviewAndPaymentController(),
            builder: (ReviewAndPaymentController controller) {
              if (controller.isLoading) {
                return Center(
                  child: IZILoading().isLoadingKit,
                );
              }
              return Container(
                color: ColorResources.BACKGROUND,
                width: IZIDimensions.iziSize.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: IZIDimensions.iziSize.width,
                        decoration: BoxDecoration(
                          color: ColorResources.WHITE,
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_5X,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_2X,
                          vertical: IZIDimensions.ONE_UNIT_SIZE * 80,
                        ),
                        margin: EdgeInsets.all(
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Reputation.
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_3X,
                              ),
                              child: _reputationRating(controller),
                            ),

                            /// Rated.
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_3X,
                              ),
                              child: _satisfactionRating(controller),
                            ),

                            /// Evaluate connection quality.
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_3X,
                              ),
                              child: _evaluationOfConnectionQuality(controller),
                            ),

                            /// Your comment.
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_3X,
                              ),
                              child: _comment(controller),
                            ),

                            /// Agree to pay.
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_3X,
                              ),
                              child: _paymentEvaluation(controller),
                            ),

                            /// Complain.
                            Obx(() {
                              if (controller.isAgreePayment.value == false) {
                                return _complain(controller);
                              }
                              return const SizedBox();
                            })
                          ],
                        ),
                      ),

                      /// Note.
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          0,
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Text(
                          'review_page_11'.tr,
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_SPAN,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),

                      /// Button.
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          IZIDimensions.SPACE_SIZE_2X,
                          0,
                          IZIDimensions.SPACE_SIZE_2X,
                          IZIDimensions.SPACE_SIZE_3X,
                        ),
                        width: IZIDimensions.iziSize.width,
                        child:
                            //Button
                            _button(controller),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  ///
  /// Reputation.
  ///
  Row _reputationRating(ReviewAndPaymentController controller) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "review_page_2".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                  fontWeight: FontWeight.w600,
                  color: ColorResources.BLACK,
                ),
              ),
              TextSpan(
                text: "*",
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                  color: ColorResources.RED,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(() => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BORDER_RADIUS_3X,
                      ),
                      border: Border.all(
                        color: ColorResources.PRIMARY_APP,
                      ),
                    ),
                    child: DropDownButton<int>(
                      isSort: false,
                      width: IZIDimensions.iziSize.width * .2,
                      data: controller.reputationList,
                      value: controller.reputation.value,
                      isRequired: false,
                      textStyleValue: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        color: ColorResources.BLACK,
                      ),
                      onChanged: (val) {
                        controller.onChangedReputation(val!);
                      },
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  ///
  /// Rated.
  ///
  Row _satisfactionRating(ReviewAndPaymentController controller) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "review_page_3".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                  color: ColorResources.BLACK,
                ),
              ),
              TextSpan(
                text: "*",
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                  color: ColorResources.RED,
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...List.generate(controller.dataRated.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.onChangedSatisfied(index: index);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            child: IZIImage(
                              controller.dataRated[index]["icon_emoji"].toString(),
                              color: ColorResources.PRIMARY_APP,
                              width: IZIDimensions.ONE_UNIT_SIZE * 45,
                              height: IZIDimensions.ONE_UNIT_SIZE * 45,
                            ),
                          ),
                          SizedBox(
                            width: IZIDimensions.ONE_UNIT_SIZE * 70,
                            height: IZIDimensions.ONE_UNIT_SIZE * 60,
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        IZIDimensions.BLUR_RADIUS_2X,
                                      ),
                                      border: Border.all(
                                        color: ColorResources.PRIMARY_APP,
                                        width: IZIDimensions.ONE_UNIT_SIZE * 3,
                                      ),
                                    ),
                                    width: IZIDimensions.ONE_UNIT_SIZE * 50,
                                    height: IZIDimensions.ONE_UNIT_SIZE * 50,
                                  ),
                                ),
                                if (controller.currentIndexSatisfied.value == index)
                                  Positioned(
                                    top: index == 0 ? IZIDimensions.ONE_UNIT_SIZE * 2 : IZIDimensions.ONE_UNIT_SIZE * 16,
                                    right: index == 0 ? IZIDimensions.ONE_UNIT_SIZE * 10 : IZIDimensions.ONE_UNIT_SIZE * 26,
                                    child: IZIImage(
                                      controller.dataRated[index]["icon_rated"].toString(),
                                      color: index == 0 ? ColorResources.DONE_ICON : ColorResources.RED,
                                      width: index == 0 ? IZIDimensions.ONE_UNIT_SIZE * 50 : IZIDimensions.ONE_UNIT_SIZE * 36,
                                      height: index == 0 ? IZIDimensions.ONE_UNIT_SIZE * 50 : IZIDimensions.ONE_UNIT_SIZE * 36,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// Evaluate connection quality.
  ///
  Column _evaluationOfConnectionQuality(ReviewAndPaymentController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: IZIDimensions.SPACE_SIZE_2X,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "review_page_4".tr,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.BLACK,
                  ),
                ),
                TextSpan(
                  text: "*",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.RED,
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => RatingBar.builder(
                initialRating: controller.valueConnectionQuality.value,
                allowHalfRating: true,
                itemPadding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.SPACE_SIZE_1X,
                ),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: ColorResources.STAR_COLOR,
                ),
                onRatingUpdate: (val) {
                  controller.onChangedConnectionQuality(val);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///
  /// Your comment.
  ///
  Widget _comment(ReviewAndPaymentController controller) {
    return Obx(() => IZIInput(
          type: IZIInputType.MULTILINE,
          isRequired: true,
          textInputAction: TextInputAction.newline,
          maxLine: 5,
          label: "review_page_5".tr,
          isBorder: true,
          colorBorder: ColorResources.PRIMARY_APP,
          fillColor: ColorResources.GREY.withOpacity(.2),
          disbleError: true,
          placeHolder: "review_page_6".tr,
          onChanged: (val) {
            controller.onChangedValueContentComment(val);
          },
          errorText: controller.errorTextContentComment.value,
          validate: (val) {
            controller.onValidateContentComment(val);
            return null;
          },
        ));
  }

  ///
  /// Agree pay.
  ///
  Row _paymentEvaluation(ReviewAndPaymentController controller) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "review_page_7".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                  color: ColorResources.BLACK,
                ),
              ),
              TextSpan(
                text: "*",
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                  color: ColorResources.RED,
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...List.generate(controller.dataConnectionQuality.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.onChangedAgreePayment(index: index);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: index == 0 ? IZIDimensions.SPACE_SIZE_2X : 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            child: IZIImage(
                              controller.dataConnectionQuality[index]["icon_emoji"].toString(),
                              color: ColorResources.PRIMARY_APP,
                              width: IZIDimensions.ONE_UNIT_SIZE * 45,
                              height: IZIDimensions.ONE_UNIT_SIZE * 45,
                            ),
                          ),
                          SizedBox(
                            width: IZIDimensions.ONE_UNIT_SIZE * 70,
                            height: IZIDimensions.ONE_UNIT_SIZE * 60,
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        IZIDimensions.BLUR_RADIUS_2X,
                                      ),
                                      border: Border.all(
                                        color: ColorResources.PRIMARY_APP,
                                        width: IZIDimensions.ONE_UNIT_SIZE * 3,
                                      ),
                                    ),
                                    width: IZIDimensions.ONE_UNIT_SIZE * 50,
                                    height: IZIDimensions.ONE_UNIT_SIZE * 50,
                                  ),
                                ),
                                if (controller.currentIndexAgreePayment.value == index)
                                  Positioned(
                                    top: index == 0 ? IZIDimensions.ONE_UNIT_SIZE * 2 : IZIDimensions.ONE_UNIT_SIZE * 16,
                                    right: index == 0 ? IZIDimensions.ONE_UNIT_SIZE * 10 : IZIDimensions.ONE_UNIT_SIZE * 26,
                                    child: IZIImage(
                                      controller.dataConnectionQuality[index]["icon_rated"].toString(),
                                      color: index == 0 ? ColorResources.DONE_ICON : ColorResources.RED,
                                      width: index == 0 ? IZIDimensions.ONE_UNIT_SIZE * 50 : IZIDimensions.ONE_UNIT_SIZE * 36,
                                      height: index == 0 ? IZIDimensions.ONE_UNIT_SIZE * 50 : IZIDimensions.ONE_UNIT_SIZE * 36,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// Complain.
  ///
  Widget _complain(ReviewAndPaymentController controller) {
    return Obx(
      () => IZIInput(
        type: IZIInputType.MULTILINE,
        isRequired: true,
        textInputAction: TextInputAction.newline,
        maxLine: 5,
        label: "review_page_8".tr,
        isBorder: true,
        colorBorder: ColorResources.PRIMARY_APP,
        disbleError: true,
        fillColor: ColorResources.GREY.withOpacity(.2),
        placeHolder: "review_page_9".tr,
        onChanged: (val) {
          controller.onChangedValueComplain(val);
        },
        errorText: controller.errorTextComplain.value,
        validate: (val) {
          controller.onValidateComplain(val);
          return null;
        },
      ),
    );
  }

  ///
  /// Button.
  ///
  Widget _button(ReviewAndPaymentController controller) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IZIButton(
            type: IZIButtonType.OUTLINE,
            width: IZIDimensions.iziSize.width * .4,
            onTap: () {
              Get.back();
            },
            label: "quay_lai".tr,
          ),
          IZIButton(
            isEnabled: controller.genBoolButtonSendRequest(),
            width: IZIDimensions.iziSize.width * .4,
            onTap: () {
              controller.onGoToPaymentSuccessfulPage();
            },
            label: "review_page_10".tr,
          ),
        ],
      ),
    );
  }
}
