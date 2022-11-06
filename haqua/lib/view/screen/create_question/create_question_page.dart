import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_box_image.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_drop_down_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/data/model/subspecialize/subspecialize_response.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/create_question/create_question_controller.dart';

import '../../../utils/images_path.dart';

class CreateQuestionPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            child: Icon(
              Icons.close_outlined,
              color: ColorResources.BLACK,
              size: IZIDimensions.ONE_UNIT_SIZE * 50,
            ),
          ),
          title: Text(
            "label_create_appbar".tr,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: IZIDimensions.FONT_SIZE_H5,
              color: ColorResources.BLACK,
            ),
          ),
        ),
        body: GetBuilder(
          init: CreateQuestionController(),
          builder: (CreateQuestionController controller) {
            if (controller.isLoading) {
              return Center(
                child: IZILoading().isLoadingKit,
              );
            }
            return SizedBox(
              width: IZIDimensions.iziSize.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// Topic Question.
                    Container(
                      key: controller.keyTopic,
                      margin: EdgeInsets.fromLTRB(
                        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        IZIDimensions.SPACE_SIZE_3X,
                        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      child: _selectedQuestion(controller),
                    ),

                    /// Import content question.
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        0,
                        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      width: IZIDimensions.iziSize.width,
                      child: _inputContentQuestion(controller),
                    ),

                    /// Images question.
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        0,
                        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      child: _addImages(controller),
                    ),

                    /// Files question.
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        0,
                        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      child: _pickFiles(controller),
                    ),

                    /// List files when import
                    Obx(() {
                      if (!IZIValidate.nullOrEmpty(controller.filesUpload)) {
                        return SizedBox(
                          width: IZIDimensions.iziSize.width,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.filesUpload.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.fromLTRB(
                                  IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                  0,
                                  IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                  IZIDimensions.SPACE_SIZE_2X,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: IZIDimensions.SPACE_SIZE_2X,
                                  vertical: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorResources.WHITE,
                                  borderRadius: BorderRadius.circular(
                                    IZIDimensions.BORDER_RADIUS_3X,
                                  ),
                                ),
                                width: IZIDimensions.iziSize.width,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.attach_file_outlined,
                                      color: ColorResources.PRIMARY_APP,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${controller.filesUpload[index].split('/').last.toString().substring(0, 25)}.........${controller.filesUpload[index].split('/').last.toString().substring(controller.filesUpload[index].split('/').last.length - 10, controller.filesUpload[index].split('/').last.length)}",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.onDeleteFiles(file: controller.filesUpload[index], files: controller.filesUpload);
                                      },
                                      child: const Icon(
                                        Icons.delete_outline,
                                        color: ColorResources.RED,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }

                      return const SizedBox();
                    }),

                    /// Hashtag question
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        0,
                        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      width: IZIDimensions.iziSize.width,
                      child: _hashtag(controller),
                    ),

                    Row(
                      children: [
                        Obx(() => Radio<int>(
                              activeColor: ColorResources.PRIMARY_APP,
                              value: controller.valueFreeRadio.value,
                              groupValue: controller.groupValueRadio.value,
                              onChanged: (val) {
                                controller.onChangedRadioButton(val: val!);
                              },
                            )),
                        Expanded(
                          child: Text(
                            "free".tr,
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              fontWeight: FontWeight.w600,
                              color: ColorResources.BLACK,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Obx(() => Radio<int>(
                              activeColor: ColorResources.PRIMARY_APP,
                              value: controller.valuePaymentRadio.value,
                              groupValue: controller.groupValueRadio.value,
                              onChanged: (val) {
                                controller.onChangedRadioButton(val: val!);
                              },
                            )),
                        Expanded(
                          child: Text(
                            "input_money".tr,
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              fontWeight: FontWeight.w600,
                              color: ColorResources.BLACK,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //Nhập giá tiền bạn muốn *
                    Obx(() {
                      if (controller.valuePaymentRadio.value == controller.groupValueRadio.value) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(
                            IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                            0,
                            IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                            IZIDimensions.ONE_UNIT_SIZE * 50,
                          ),
                          width: IZIDimensions.iziSize.width,
                          child: _inputMoney(controller),
                        );
                      }

                      return const SizedBox();
                    }),

                    /// Continue Button.
                    _buttonContinue(controller),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ///
  /// Topic question.
  ///
  Widget _selectedQuestion(CreateQuestionController controller) {
    return Obx(
      () => Column(
        children: [
          DropDownButton<SubSpecializeResponse>(
            data: controller.subSpecializeList,
            isRequired: true,
            value: !IZIValidate.nullOrEmpty(controller.specializeResponse.value.id) ? controller.specializeResponse.value : null,
            label: "topic_question".tr,
            onChanged: (val) {
              controller.onChangedTopic(val!);
            },
            isSort: false,
            hint: "hint_text_topic_question".tr,
          ),
          if (IZIValidate.nullOrEmpty(controller.specializeResponse.value.id) && controller.isFirstValidateTopic.value == true)
            Container(
              margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
              alignment: Alignment.topLeft,
              child: Text(
                "validate_topic_question".tr,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: ColorResources.RED,
                ),
              ),
            ),
        ],
      ),
    );
  }

  ///
  /// Import content question.
  ///
  Widget _inputContentQuestion(CreateQuestionController controller) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_1X,
            ),
            child: Row(
              children: [
                Text(
                  "content_question".tr,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.BLACK,
                  ),
                ),
                Text(
                  "*",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            onChanged: (val) {
              controller.onChangedContentQuestion(val);
            },
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            textAlignVertical: TextAlignVertical.top,
            enabled: true,
            controller: controller.contentQuestionController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              isDense: true,
              suffixIcon: GestureDetector(
                onTap: controller.speech.isNotListening
                    ? () {
                        controller.startListening();
                      }
                    : () {
                        controller.stopListening();
                      },
                child: AvatarGlow(
                  animate: controller.speech.isListening,
                  glowColor: ColorResources.PRIMARY_APP,
                  endRadius: IZIDimensions.ONE_UNIT_SIZE * 40,
                  child: Icon(
                    controller.speech.isListening ? Icons.mic_rounded : Icons.mic_off_rounded,
                    size: IZIDimensions.ONE_UNIT_SIZE * 50,
                    color: controller.speech.isListening ? ColorResources.PRIMARY_APP : ColorResources.RED,
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BLUR_RADIUS_3X,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BLUR_RADIUS_3X,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BLUR_RADIUS_3X,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BLUR_RADIUS_3X,
                ),
              ),
              filled: true,
              hintText: "hint_text_content_question".tr,
              hintStyle: TextStyle(
                color: ColorResources.BLACK.withOpacity(0.5),
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
              ),
              fillColor: ColorResources.WHITE,
            ),
          ),
          if (controller.isErrorTextContent.value == true)
            Container(
              margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
              alignment: Alignment.topLeft,
              child: Text(
                "validate_content_question".tr,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: ColorResources.RED,
                ),
              ),
            ),
        ],
      ),
    );
  }

  ///
  /// Images question.
  ///
  Column _addImages(CreateQuestionController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: IZIDimensions.SPACE_SIZE_1X * .5,
          ),
          child: Text(
            "image".tr,
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
              fontWeight: FontWeight.w600,
              color: ColorResources.BLACK,
            ),
          ),
        ),
        Obx(
          () => IZIBoxImage(
            images: !IZIValidate.nullOrEmpty(controller.imagesUpload) ? controller.imagesUpload : [],
            isAddImage: true,
            onDelete: (val, values) {
              controller.onDeleteImage(file: val, files: values);
            },
            onPress: () {
              controller.pickImages();
            },
            onPreviewImages: (val, values) {
              controller.onGoToPreviewImage(urlImage: val);
            },
          ),
        ),
      ],
    );
  }

  ///
  /// Files question.
  ///
  SizedBox _pickFiles(CreateQuestionController controller) {
    return SizedBox(
      width: IZIDimensions.iziSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "file".tr,
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
              fontWeight: FontWeight.w600,
              color: ColorResources.BLACK,
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.pickFiles();
            },
            child: Container(
              width: IZIDimensions.iziSize.width * .26,
              height: IZIDimensions.ONE_UNIT_SIZE * 60,
              decoration: BoxDecoration(
                color: ColorResources.PRIMARY_APP.withOpacity(.3),
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BORDER_RADIUS_7X,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    child: Text(
                      "upload".tr,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        fontWeight: FontWeight.w600,
                        color: ColorResources.BLACK,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
                    decoration: BoxDecoration(
                      color: ColorResources.PRIMARY_APP,
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BORDER_RADIUS_7X,
                      ),
                    ),
                    child: const Icon(
                      Icons.upload_file_outlined,
                      color: ColorResources.WHITE,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///
  /// Hashtag question.
  ///
  Widget _hashtag(CreateQuestionController controller) {
    return Obx(() => SizedBox(
          width: IZIDimensions.iziSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: IZIDimensions.SPACE_SIZE_1X,
                ),
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: "Hashtag",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      fontWeight: FontWeight.w600,
                      color: ColorResources.BLACK,
                    ),
                    children: [
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: IZIDimensions.iziSize.width,
                decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BLUR_RADIUS_3X,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onChanged: (val) {
                        controller.onChangedHashtag(val);
                      },
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      textAlignVertical: TextAlignVertical.top,
                      enabled: true,
                      controller: controller.controllerRichText,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(
                          IZIDimensions.SPACE_SIZE_3X,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BLUR_RADIUS_3X,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                        filled: true,
                        hintText: "#haqua #vatly #chungkhoang",
                        hintStyle: TextStyle(
                          color: ColorResources.BLACK.withOpacity(0.5),
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        ),
                        fillColor: ColorResources.WHITE,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setHashtag();
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: IZIDimensions.SPACE_SIZE_2X,
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        padding: EdgeInsets.all(
                          IZIDimensions.SPACE_SIZE_2X,
                        ),
                        width: IZIDimensions.ONE_UNIT_SIZE * 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorResources.GREY.withOpacity(.6),
                          ),
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BLUR_RADIUS_2X,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '# Hashtag',
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_SPAN,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (controller.isErrorTextHashtag.value == true)
                Container(
                  margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "validate_hashtag".tr,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: ColorResources.RED,
                    ),
                  ),
                ),
              if (!IZIValidate.nullOrEmpty(controller.suggestedHashtag))
                //List Sugguest Data Hashtag
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.suggestedHashtag.length <= 5 ? controller.suggestedHashtag.length : 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.setValueHashTag(value: controller.suggestedHashtag[index].toString());
                      },
                      child: Container(
                        key: index == 2 ? controller.keyButtonTopic : null,
                        decoration: const BoxDecoration(
                          color: ColorResources.WHITE,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: IZIDimensions.SPACE_SIZE_5X,
                          horizontal: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        width: IZIDimensions.iziSize.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.suggestedHashtag[index].toString(),
                              ),
                            ),
                            IZIImage(
                              ImagesPath.fire_icon,
                              color: ColorResources.PRIMARY_APP,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
            ],
          ),
        ));
  }

  ///
  /// Import price you want.
  ///
  Column _inputMoney(CreateQuestionController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: IZIInput(
                label: "from".tr,
                type: IZIInputType.PRICE_NOT_ALLOW_NULL,
                isBorder: true,
                colorBorder: ColorResources.PRIMARY_APP,
                placeHolder: "hint_text_input_money".tr,
                disbleError: true,
                onChanged: (val) {
                  controller.onValidateMoneyFrom(val);
                },
                errorText: controller.errorTextMoneyFrom.value,
                validate: (val) {
                  controller.onChangedValueMoneyFrom(val);
                  return null;
                },
              ),
            ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_2X,
            ),
            Expanded(
              child: IZIInput(
                label: "to".tr,
                type: IZIInputType.PRICE_NOT_ALLOW_NULL,
                isBorder: true,
                colorBorder: ColorResources.PRIMARY_APP,
                placeHolder: "hint_text_input_money".tr,
                disbleError: true,
                onChanged: (val) {
                  controller.onValidateMoneyTo(val);
                },
                errorText: controller.errorTextMoneyTo.value,
                validate: (val) {
                  controller.onChangedValueMoneyTo(val);
                  return null;
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  ///
  /// Continue Button.
  ///
  Widget _buttonContinue(CreateQuestionController controller) {
    return Obx(
      () => IZIButton(
        isEnabled: controller.genValueEnableButton(),
        margin: EdgeInsets.fromLTRB(
          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
          0,
          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
          IZIDimensions.SPACE_SIZE_2X,
        ),
        onTap: () {
          controller.goToAskAndAnswer();
        },
        label: "continue".tr,
      ),
    );
  }
}
