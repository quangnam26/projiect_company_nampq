import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_premium.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/help_wating_list/help_wating_list_controller.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HelpWatingListPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundApp(),
      appBar: IZIAppBar(
        title: "Help_waiting_list".tr,
      ),
      body: GetBuilder(
        init: HelpWatingListController(),
        builder: (HelpWatingListController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return Container(
            width: IZIDimensions.iziSize.width,
            color: ColorResources.WHITE,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (controller.questionResponse.value.statusQuestion != CANCELED) {
                      return

                          /// Recipients who answer your questions
                          SizedBox(
                        width: IZIDimensions.iziSize.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                IZIDimensions.SPACE_SIZE_5X,
                                IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                IZIDimensions.SPACE_SIZE_2X,
                              ),
                              child: Text(
                                "Recipients_answer".tr,
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  fontWeight: FontWeight.w600,
                                  color: ColorResources.BLACK,
                                ),
                              ),
                            ),

                            /// Animated image waiting.
                            if (IZIValidate.nullOrEmpty(controller.questionResponse.value.answerList))
                              SizedBox(
                                width: IZIDimensions.iziSize.width,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      ImagesPath.wating_answer_ques_gift,
                                      height: IZIDimensions.ONE_UNIT_SIZE * 180,
                                      width: IZIDimensions.ONE_UNIT_SIZE * 180,
                                    ),
                                    DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                        color: ColorResources.BLACK,
                                      ),
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          WavyAnimatedText(
                                            'Waiting'.tr,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                        repeatForever: true,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            else

                              /// Help Waiting List.
                              SizedBox(
                                width: IZIDimensions.iziSize.width,
                                height: IZIDimensions.iziSize.height * .30,
                                child: ListView.builder(
                                  itemCount: controller.questionResponse.value.answerList!.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                        left: index == 0 ? 0 : IZIDimensions.SPACE_SIZE_1X,
                                      ),
                                      width: IZIDimensions.iziSize.width * .33,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: IZIDimensions.SPACE_SIZE_2X,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                controller.goToDetailProfilePeoplePage(
                                                  idUser: controller.questionResponse.value.answerList![index].idUser!.id.toString(),
                                                  idAnswerer: controller.questionResponse.value.answerList![index].id.toString(),
                                                  statusSelect: controller.questionResponse.value.answerList![index].statusSelect.toString(),
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  ClipOval(
                                                    child: Container(
                                                      color: controller.questionResponse.value.answerList![index].statusSelect == SELECTED ? ColorResources.SUCCESSFUL_PAGE : Colors.transparent,
                                                      width: IZIDimensions.iziSize.width * .27,
                                                      height: IZIDimensions.iziSize.width * .27,
                                                      child: Center(
                                                        child: ClipOval(
                                                          child: IZIImage(
                                                            IZIValidate().getTypeAvatarString(controller.questionResponse.value.answerList![index].idUser!.avatar.toString()),
                                                            width: IZIDimensions.iziSize.width * .25,
                                                            height: IZIDimensions.iziSize.width * .25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  if (controller.questionResponse.value.answerList![index].statusSelect == SELECTED)
                                                    Positioned(
                                                      bottom: 0,
                                                      left: IZIDimensions.iziSize.width * .11,
                                                      child: SvgPicture.asset(
                                                        ImagesPath.help_waiting_icon_check,
                                                        width: IZIDimensions.ONE_UNIT_SIZE * 45,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: IZIDimensions.SPACE_SIZE_1X - IZIDimensions.ONE_UNIT_SIZE * 5,
                                            ),
                                            child: Text(
                                              controller.questionResponse.value.answerList![index].idUser!.fullName.toString(),
                                              style: TextStyle(
                                                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                                color: ColorResources.BLACK,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: IZIDimensions.SPACE_SIZE_1X - IZIDimensions.ONE_UNIT_SIZE * 5,
                                            ),
                                            child: SizedBox(
                                              width: IZIDimensions.iziSize.width * .15,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                      right: IZIDimensions.SPACE_SIZE_1X,
                                                    ),
                                                    child: Icon(
                                                      Icons.star,
                                                      color: ColorResources.STAR_COLOR,
                                                      size: IZIDimensions.ONE_UNIT_SIZE * 30,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          controller.questionResponse.value.answerList![index].idUser!.statisticReview!.totalRating == 0 || controller.questionResponse.value.answerList![index].idUser!.statisticReview!.countRating == 0 ? '0.0' : (controller.questionResponse.value.answerList![index].idUser!.statisticReview!.totalRating! / controller.questionResponse.value.answerList![index].idUser!.statisticReview!.countRating!).toStringAsPrecision(2),
                                                          style: TextStyle(
                                                            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                                            color: ColorResources.BLACK,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.questionResponse.value.answerList![index].price))}vnđ",
                                            style: TextStyle(
                                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                              color: ColorResources.RED,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  }),

                  /// Detail question.
                  Obx(() => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          vertical: controller.questionResponse.value.statusQuestion != CANCELED ? 0 : IZIDimensions.SPACE_SIZE_3X,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Status question.
                            _detailQuestions(
                              topic: 'status'.tr,
                              isMarginBottom: true,
                              colorDetail: ColorResources.PRIMARY_APP,
                              isGenStatusQuestion: true,
                              statusQuestion: controller.questionResponse.value.statusQuestion,
                            ),

                            /// Topic question.
                            _detailQuestions(
                              topic: 'topic_question'.tr,
                              detail: controller.questionResponse.value.idSubSpecialize!.name.toString(),
                              isMarginBottom: true,
                            ),

                            /// Hashtag question.
                            _detailQuestions(
                              topic: 'Hashtag',
                              detail: controller.questionResponse.value.hashTag.toString(),
                              isMarginBottom: true,
                            ),

                            /// Content question.
                            _detailQuestions(
                              topic: 'Content_question'.tr,
                              detail: controller.questionResponse.value.content.toString(),
                              isMarginBottom: true,
                            ),

                            if (!controller.isShowMore.value)
                              SizedBox(
                                width: IZIDimensions.iziSize.width,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.onChangeStatusShowMore();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: IZIDimensions.SPACE_SIZE_2X,
                                        ),
                                        padding: EdgeInsets.all(
                                          IZIDimensions.SPACE_SIZE_1X,
                                        ),
                                        decoration: BoxDecoration(
                                            color: ColorResources.WHITE,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: ColorResources.PRIMARY_APP,
                                            )),
                                        child: const Center(
                                          child: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            color: ColorResources.PRIMARY_APP,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'xem_them'.tr,
                                        style: TextStyle(
                                          color: ColorResources.PRIMARY_APP,
                                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            if (controller.isShowMore.value)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Call time (minutes).
                                  _detailQuestions(
                                    topic: '${'Call_time'.tr}(${'minute'.tr})',
                                    detail: '${(IZINumber.parseDouble(controller.questionResponse.value.timeUsed) / 60).toStringAsFixed(0)}/30',
                                    isMarginBottom: true,
                                  ),

                                  /// Question creation date.
                                  _detailQuestions(
                                    topic: 'Question_creation'.tr,
                                    detail: IZIDate.formatDate(controller.questionResponse.value.createdAt!),
                                    isMarginBottom: true,
                                  ),

                                  /// Call cost.
                                  _detailQuestions(
                                    topic: 'Call_cost'.tr,
                                    detail: controller.genValueCallCost(),
                                    isMarginBottom: true,
                                    colorDetail: ColorResources.RED,
                                  ),

                                  /// Comment question.
                                  _detailQuestions(
                                    topic: 'Your_comment'.tr,
                                    detail: !IZIValidate.nullOrEmpty(controller.questionResponse.value.comment) ? controller.questionResponse.value.comment.toString() : 'Not_available'.tr,
                                    isMarginBottom: true,
                                  ),

                                  /// Complain question.
                                  _detailQuestions(
                                    topic: 'Complain'.tr,
                                    detail: !IZIValidate.nullOrEmpty(controller.questionResponse.value.complains) ? controller.questionResponse.value.complains!.last.content.toString() : 'Not_available'.tr,
                                    isMarginBottom: true,
                                  ),

                                  /// Report question.
                                  _detailQuestions(
                                    topic: 'Report'.tr,
                                    detail: !IZIValidate.nullOrEmpty(controller.questionResponse.value.denounce) ? controller.questionResponse.value.denounce.toString() : 'Not_available'.tr,
                                    isMarginBottom: true,
                                  ),
                                ],
                              ),

                            if (controller.isShowMore.value)
                              SizedBox(
                                width: IZIDimensions.iziSize.width,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.onChangeStatusShowMore();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: IZIDimensions.SPACE_SIZE_2X,
                                        ),
                                        padding: EdgeInsets.all(
                                          IZIDimensions.SPACE_SIZE_1X,
                                        ),
                                        decoration: BoxDecoration(
                                            color: ColorResources.WHITE,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: ColorResources.PRIMARY_APP,
                                            )),
                                        child: const Center(
                                          child: Icon(
                                            Icons.keyboard_arrow_up_outlined,
                                            color: ColorResources.PRIMARY_APP,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'rut_gon'.tr,
                                        style: TextStyle(
                                          color: ColorResources.PRIMARY_APP,
                                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )),

                  Obx(() {
                    /// Button with status question.
                    if (controller.questionResponse.value.statusQuestion == SELECTED_PERSON) {
                      return IZIButton(
                        margin: EdgeInsets.fromLTRB(
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          IZIDimensions.SPACE_SIZE_5X,
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          IZIDimensions.SPACE_SIZE_2X,
                        ),
                        onTap: () {
                          controller.goToCallScreenPage();
                        },
                        label: "Make_call".tr,
                      );
                    } else if (controller.questionResponse.value.statusQuestion == CONNECTING) {
                      return IZIButton(
                        margin: EdgeInsets.fromLTRB(
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          IZIDimensions.SPACE_SIZE_5X,
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          IZIDimensions.SPACE_SIZE_2X,
                        ),
                        onTap: () {
                          controller.onShowDialog();
                        },
                        colorBG: ColorResources.RED,
                        label: "Delete_question".tr,
                      );
                    } else if (controller.questionResponse.value.statusQuestion == CALLED) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          IZIDimensions.SPACE_SIZE_5X,
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IZIButton(
                              width: IZIDimensions.iziSize.width * .45,
                              onTap: () {
                                controller.goToCallScreenPage();
                              },
                              label: "btn_call_again".tr,
                            ),
                            IZIButton(
                              width: IZIDimensions.iziSize.width * .45,
                              onTap: () {
                                controller.showDialogCompleteStatusQuestion();
                              },
                              colorBG: ColorResources.CALL_VIDEO,
                              label: "btn_done".tr,
                            )
                          ],
                        ),
                      );
                    } else if (controller.questionResponse.value.statusQuestion == COMPLETED && controller.questionResponse.value.mySharePrice == -1) {
                      return IZIButton(
                        margin: EdgeInsets.fromLTRB(
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          IZIDimensions.SPACE_SIZE_5X,
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          IZIDimensions.SPACE_SIZE_2X,
                        ),
                        onTap: () {
                          controller.goToShareVideo();
                        },
                        label: "btn_share".tr,
                      );
                    }

                    return const SizedBox();
                  })
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// Common details question.
  ///
  Widget _detailQuestions({
    required String topic,
    String? detail,
    bool? isGenStatusQuestion,
    String? statusQuestion,
    Color? colorDetail,
    required bool isMarginBottom,
  }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: isMarginBottom == true ? IZIDimensions.SPACE_SIZE_5X : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_1X,
            ),
            child: Text(
              topic,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: ColorResources.BLACK,
                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
              ),
            ),
          ),
          if (!IZIValidate.nullOrEmpty(isGenStatusQuestion))
            IZIValidate.getTypeStatusQuestion(statusQuestion)
          else
            Text(
              detail!,
              style: TextStyle(
                color: colorDetail ?? ColorResources.BLACK,
                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
              ),
            ),
        ],
      ),
    );
  }
}
