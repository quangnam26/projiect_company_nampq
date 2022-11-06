import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_premium.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_drop_down_button.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/create_question/ask_and_answer/ask_and_answer_controller.dart';

class AskAndAnswerPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundApp(),
      appBar: IZIAppBar(
        title: "ask_and_answer_appbar".tr,
      ),
      body: GetBuilder(
        init: AskAndAnswerController(),
        builder: (AskAndAnswerController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return Container(
            color: ColorResources.BACKGROUND,
            width: IZIDimensions.iziSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                    IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    IZIDimensions.SPACE_SIZE_3X,
                    IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: Text(
                    "priority_mode".tr,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      fontWeight: FontWeight.w600,
                      color: ColorResources.BLACK,
                    ),
                  ),
                ),

                /// Lang.uage
                _language(controller),

                /// Gender.
                _sex(controller),

                /// Region.
                _region(controller),

                ///Specialize
                Container(
                  width: IZIDimensions.iziSize.width,
                  margin: EdgeInsets.fromLTRB(
                    IZIDimensions.SPACE_SIZE_5X,
                    0,
                    IZIDimensions.SPACE_SIZE_5X,
                    IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: _specialize(controller),
                ),

                /// Execution time.
                Container(
                  margin: EdgeInsets.fromLTRB(
                    IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    0,
                    IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    IZIDimensions.SPACE_SIZE_2X,
                  ),
                  width: IZIDimensions.iziSize.width,
                  child: _time(),
                ),
              ],
            ),
          );
        },
      ),
      widgetBottomSheet: GetBuilder(
        init: AskAndAnswerController(),
        builder: (AskAndAnswerController controller) {
          /// Create question button.
          return Obx(() => IZIButton(
                isEnabled: controller.isEnableButton.value,
                margin: EdgeInsets.fromLTRB(
                  IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                  0,
                  IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                  IZIDimensions.SPACE_SIZE_2X,
                ),
                onTap: () {
                  controller.onCreateQuestion();
                },
                label: "start_search".tr,
              ));
        },
      ),
    );
  }

  ///
  /// Language.
  ///
  Widget _language(AskAndAnswerController controller) {
    return Obx(() => Container(
          margin: EdgeInsets.fromLTRB(
            IZIDimensions.PADDING_HORIZONTAL_SCREEN,
            0,
            IZIDimensions.PADDING_HORIZONTAL_SCREEN,
            IZIDimensions.SPACE_SIZE_2X,
          ),
          child: Column(
            children: [
              DropDownButton<String>(
                label: "foreign_language".tr,
                data: LANGUAGE_CREATE_QUESTION,
                isRequired: true,
                value: !IZIValidate.nullOrEmpty(controller.isSelectedLanguageCreateQuestion.value) ? controller.isSelectedLanguageCreateQuestion.value : null,
                onChanged: (val) {
                  controller.onChangedLanguage(val: val!);
                },
                isSort: false,
                hint: "foreign_language".tr,
              ),
              if (IZIValidate.nullOrEmpty(controller.isSelectedLanguageCreateQuestion) && controller.isFirstValidateLanguage.value == true)
                Container(
                  margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "validate_priority_mode".tr,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: ColorResources.RED,
                    ),
                  ),
                ),
            ],
          ),
        ));
  }

  ///
  /// Gender.
  ///
  Widget _sex(AskAndAnswerController controller) {
    return Obx(() => Container(
          margin: EdgeInsets.fromLTRB(
            IZIDimensions.PADDING_HORIZONTAL_SCREEN,
            0,
            IZIDimensions.PADDING_HORIZONTAL_SCREEN,
            IZIDimensions.SPACE_SIZE_2X,
          ),
          child: Column(
            children: [
              DropDownButton<String>(
                label: "gender".tr,
                data: GENDER_DATA_CREATE_QUESTION,
                isRequired: true,
                value: !IZIValidate.nullOrEmpty(controller.isSelectedGenderCreateQuestion.value) ? controller.isSelectedGenderCreateQuestion.value : null,
                onChanged: (val) {
                  controller.onChangedGender(val: val!);
                },
                isSort: false,
                hint: "gender".tr,
              ),
              if (IZIValidate.nullOrEmpty(controller.isSelectedGenderCreateQuestion) && controller.isFirstValidateGender.value == true)
                Container(
                  margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "validate_gender".tr,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: ColorResources.RED,
                    ),
                  ),
                ),
            ],
          ),
        ));
  }

  ///
  /// Region.
  ///
  Widget _region(AskAndAnswerController controller) {
    return Obx(() => Container(
          margin: EdgeInsets.fromLTRB(
            IZIDimensions.PADDING_HORIZONTAL_SCREEN,
            0,
            IZIDimensions.PADDING_HORIZONTAL_SCREEN,
            IZIDimensions.SPACE_SIZE_5X,
          ),
          child: Column(
            children: [
              DropDownButton<String>(
                label: "region".tr,
                data: REGION_DATA_CREATE_QUESTION,
                isRequired: true,
                value: !IZIValidate.nullOrEmpty(controller.isSelectedRegionCreateQuestion.value) ? controller.isSelectedRegionCreateQuestion.value : null,
                onChanged: (val) {
                  controller.onChangedRegion(val: val!);
                },
                isSort: false,
                hint: "region".tr,
              ),
              if (IZIValidate.nullOrEmpty(controller.isSelectedRegionCreateQuestion) && controller.isFirstValidateRegion.value == true)
                Container(
                  margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "validate_region".tr,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: ColorResources.RED,
                    ),
                  ),
                ),
            ],
          ),
        ));
  }

  ///
  /// Specialize.
  ///
  Widget _specialize(AskAndAnswerController controller) {
    return Obx(() => Wrap(
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: IZIDimensions.SPACE_SIZE_1X,
          children: List.generate(
            controller.DATA_CREATE_QUESTION_ASK_AND_ANSWER.length,
            (index) {
              return Container(
                margin: EdgeInsets.only(
                  bottom: IZIDimensions.SPACE_SIZE_2X,
                ),
                child: ChoiceChip(
                  backgroundColor: ColorResources.GREY,
                  labelPadding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_2X,
                    vertical: IZIDimensions.SPACE_SIZE_1X,
                  ),
                  label: Text(
                    controller.DATA_CREATE_QUESTION_ASK_AND_ANSWER[index]['name'].toString(),
                    style: TextStyle(
                      color: ColorResources.WHITE,
                      fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    ),
                  ),
                  selected: controller.DATA_CREATE_QUESTION_ASK_AND_ANSWER[index]['isSelected'] as bool,
                  selectedColor: ColorResources.PRIMARY_APP,
                  onSelected: (value) {
                    controller.onSelected(index: index, val: value);
                  },
                  // backgroundColor: color,
                  elevation: 0,
                ),
              );
            },
          ),
        ));
  }

  ///
  /// Execution time.
  ///
  Widget _time() {
    return Row(
      children: [
        const Icon(
          Icons.timer_outlined,
          color: ColorResources.PRIMARY_BLUE_APP,
        ),
        Text(
          "execution_time".tr,
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
            fontWeight: FontWeight.w600,
            color: ColorResources.BLACK,
          ),
        ),
        BorderedText(
          strokeWidth: IZIDimensions.ONE_UNIT_SIZE * 5,
          strokeColor: ColorResources.BLACK,
          child: Text(
            '30 ${'minute'.tr}',
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
              fontWeight: FontWeight.w600,
              color: ColorResources.WHITE,
            ),
          ),
        ),
      ],
    );
  }
}
