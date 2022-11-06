import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';

import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/account_user/briefcase/briefcase_controller.dart';

import '../../../../base_widget/izi_button.dart';
import '../../../../helper/izi_date.dart';

class BriefCasePage extends GetView<BriefCaseController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      appBar: IZIAppBar(
        title: 'ho_so'.tr,
        colorTitle: ColorResources.BLACK,
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorResources.BLACK,
            size: IZIDimensions.ONE_UNIT_SIZE * 45,
          ),
        ),
      ),
      body: GetBuilder(
        init: BriefCaseController(),
        builder: (BriefCaseController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return SizedBox(
            width: IZIDimensions.iziSize.width,
            height: IZIDimensions.iziSize.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //File
                    Container(
                      margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_5X),
                      width: IZIDimensions.iziSize.width,
                      child: _file(controller),
                    ),

                    //Experience
                    Container(
                      margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
                      width: IZIDimensions.iziSize.width,
                      child: _experience(controller),
                    ),

                    //Certificates.
                    Container(
                      margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
                      width: IZIDimensions.iziSize.width,
                      child: _certificates(controller),
                    ),

                    //Rate
                    Container(
                      margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_5X),
                      width: IZIDimensions.iziSize.width,
                      child: _rate(controller),
                    ),

                    //Comment
                    Container(
                      margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_5X),
                      child: _comment(controller),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      widgetBottomSheet: GetBuilder(
        init: BriefCaseController(),
        builder: (BriefCaseController controller) {
          return IZIButton(
            margin: EdgeInsets.fromLTRB(
              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
              0,
              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
              IZIDimensions.SPACE_SIZE_2X,
            ),
            onTap: () {
              controller.goToUpdateFiles();
            },
            label: 'update'.tr,
          );
        },
      ),
    );
  }

  ///
  ///File
  ///
  Widget _file(BriefCaseController controller) {
    return Obx(() => Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: ClipOval(
                      child: IZIImage(
                        !IZIValidate.nullOrEmpty(controller.userResponse.value.avatar) ? controller.userResponse.value.avatar.toString() : ImagesPath.splash_haqua,
                        width: IZIDimensions.ONE_UNIT_SIZE * 180,
                        height: IZIDimensions.ONE_UNIT_SIZE * 180,
                      ),
                    ),
                  ),
                  Text(
                    controller.userResponse.value.fullName.toString(),
                    style: TextStyle(
                      color: ColorResources.BLACK,
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Container(
              color: ColorResources.BLACK,
              width: IZIDimensions.ONE_UNIT_SIZE * .5,
              height: IZIDimensions.iziSize.width * .3,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: Text(
                      'Reputation'.tr,
                      style: TextStyle(
                        color: ColorResources.BLACK,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      ),
                    ),
                  ),
                  Text(
                    "${(controller.userResponse.value.statisticReview!.totalReputation != 0 && controller.userResponse.value.statisticReview!.countReputation != 0) ? (controller.userResponse.value.statisticReview!.totalReputation! / controller.userResponse.value.statisticReview!.countReputation!).toStringAsPrecision(2) : '0'}/10",
                    style: TextStyle(
                      color: ColorResources.BLACK,
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  ///
  ///Experience
  ///
  Widget _experience(BriefCaseController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_2X,
              ),
              child: Text(
                'linh_vuc_kinh_nghiem'.tr,
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (!IZIValidate.nullOrEmpty(controller.userResponse.value.experiences))
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.genItemCount(),
                itemBuilder: (context, index) {
                  return Container(
                    width: IZIDimensions.iziSize.width,
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    padding: EdgeInsets.all(
                      IZIDimensions.SPACE_SIZE_3X,
                    ),
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BORDER_RADIUS_4X,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              child: Text(
                                'Field'.tr,
                                style: TextStyle(
                                  color: ColorResources.BLACK,
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                controller.userResponse.value.experiences![index].fieldName.toString(),
                                style: TextStyle(
                                  color: ColorResources.BLACK,
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Years_experience'.tr,
                              style: TextStyle(
                                color: ColorResources.BLACK,
                                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                controller.userResponse.value.experiences![index].year.toString(),
                                style: TextStyle(
                                  color: ColorResources.BLACK,
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            else
              Container(
                margin: EdgeInsets.only(
                  bottom: IZIDimensions.SPACE_SIZE_2X,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not_updated_yet".tr,
                      style: TextStyle(
                        color: ColorResources.BLACK,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      ),
                    ),
                  ],
                ),
              ),
            if (!IZIValidate.nullOrEmpty(controller.userResponse.value.experiences))
              if (controller.userResponse.value.experiences!.length > 5)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (controller.isShowMore.value == false)
                      GestureDetector(
                        onTap: () {
                          controller.onChangedShowMore();
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'xem_them'.tr,
                                style: TextStyle(
                                  color: ColorResources.SUCCESSFUL_PAGE,
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const WidgetSpan(
                                child: Icon(
                                  Icons.unfold_more_rounded,
                                  color: ColorResources.SUCCESSFUL_PAGE,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: () {
                          controller.onChangedShowMore();
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'rut_gon'.tr,
                                style: TextStyle(
                                  color: ColorResources.SUCCESSFUL_PAGE,
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const WidgetSpan(
                                child: Icon(
                                  Icons.unfold_less_rounded,
                                  color: ColorResources.SUCCESSFUL_PAGE,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
          ],
        ));
  }

  ///
  /// Certificates.
  ///
  Widget _certificates(BriefCaseController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_2X,
              ),
              child: Text(
                'certificate'.tr,
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (!IZIValidate.nullOrEmpty(controller.historyQuizResponseList))
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.historyQuizResponseList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    width: IZIDimensions.iziSize.width,
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BORDER_RADIUS_2X,
                      ),
                      color: ColorResources.WHITE,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_2X,
                          ),
                          child: IZIImage(
                            controller.historyQuizResponseList[index].idCertificate!.thumbnail.toString(),
                            width: IZIDimensions.ONE_UNIT_SIZE * 140,
                            height: IZIDimensions.ONE_UNIT_SIZE * 140,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_1X,
                                  ),
                                  child: Text(
                                    controller.historyQuizResponseList[index].idCertificate!.title.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_1X,
                                  ),
                                  child: Text(
                                    '${'percent_certi'.tr} ${controller.historyQuizResponseList[index].percent!.toStringAsFixed(0)}/100%',
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_1X,
                                  ),
                                  child: Text(
                                    '${'number_exam_certi'.tr} ${controller.historyQuizResponseList[index].numberTest}',
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_1X,
                                  ),
                                  child: Text(
                                    '${'last_date_certi'.tr} ${IZIDate.formatDate(controller.historyQuizResponseList[index].updatedAt!)}',
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            else
              Container(
                margin: EdgeInsets.only(
                  bottom: IZIDimensions.SPACE_SIZE_2X,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not_updated_yet".tr,
                      style: TextStyle(
                        color: ColorResources.BLACK,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ));
  }

  ///
  ///Rate
  ///
  Widget _rate(BriefCaseController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          child: IZIImage(
                            ImagesPath.logo_satisfied,
                            width: IZIDimensions.ONE_UNIT_SIZE * 60,
                            height: IZIDimensions.ONE_UNIT_SIZE * 60,
                            color: ColorResources.PRIMARY_APP,
                          ),
                        ),
                        Text(
                          '${'Satisfied'.tr} (${controller.userResponse.value.statisticReview!.numberStatisfied!.toStringAsFixed(0)})',
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          child: IZIImage(
                            ImagesPath.logo_unsatisfied,
                            width: IZIDimensions.ONE_UNIT_SIZE * 60,
                            height: IZIDimensions.ONE_UNIT_SIZE * 60,
                            color: ColorResources.PRIMARY_APP,
                          ),
                        ),
                        Text(
                          '${'Unsatisfied'.tr} (${controller.userResponse.value.statisticReview!.numberNotStatisfied!.toStringAsFixed(0)})',
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //Number of Reviews
            _numbersOfReviews(controller),
          ],
        ));
  }

  ///
  ///Number of Reviews
  ///
  Widget _numbersOfReviews(BriefCaseController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_1X),
              child: Text(
                'luot_danh_gia'.tr,
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: (controller.userResponse.value.statisticReview!.totalRating != 0 && controller.userResponse.value.statisticReview!.countRating != 0) ? (controller.userResponse.value.statisticReview!.totalRating! / controller.userResponse.value.statisticReview!.countRating!) : 0,
                  minRating: 1,
                  allowHalfRating: true,
                  itemPadding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_1X,
                  ),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: ColorResources.STAR_COLOR,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
          ],
        ));
  }

  ///
  /// Comment
  ///
  Widget _comment(BriefCaseController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X,
              ),
              child: Text(
                "Comment".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  color: ColorResources.BLACK,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (IZIValidate.nullOrEmpty(controller.reviewsResponseList))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "validate_comment".tr,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    ),
                  ),
                ],
              )
            else
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.reviewsResponseList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: index == 0 ? 0 : IZIDimensions.SPACE_SIZE_3X,
                    ),
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_4X,
                      ),
                      border: Border.all(
                        width: IZIDimensions.ONE_UNIT_SIZE * 1,
                        color: ColorResources.GREY,
                      ),
                    ),
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                    width: IZIDimensions.iziSize.width,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: IZIDimensions.SPACE_SIZE_3X,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              IZIDimensions.BLUR_RADIUS_3X,
                            ),
                            child: IZIImage(
                              IZIValidate().getTypeAvatarString(controller.reviewsResponseList[index].idAnswerer!.avatar.toString()),
                              width: IZIDimensions.iziSize.width * .18,
                              height: IZIDimensions.iziSize.width * .18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                child: Text(
                                  controller.reviewsResponseList[index].idAnswerer!.fullName.toString(),
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    color: ColorResources.CALL_VIDEO,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                controller.reviewsResponseList[index].content.toString(),
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  color: ColorResources.BLACK,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ));
  }
}
