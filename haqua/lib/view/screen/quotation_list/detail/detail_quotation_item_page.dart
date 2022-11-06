import 'dart:io';
import 'package:flutter/material.dart';
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
import 'package:template/helper/izi_size.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/quotation_list/detail/detail_quotation_controller.dart';

class DetailQuotationItemPage extends GetView<DetailQuotationController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: IZIScreen(
        isSingleChildScrollView: false,
        background: const BackgroundApp(),
        appBar: IZIAppBar(
          title: "Detail_uotes".tr,
        ),
        body: SizedBox(
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.iziSize.height,
          child: GetBuilder<DetailQuotationController>(
              init: DetailQuotationController(),
              builder: (DetailQuotationController controller) {
                if (controller.isLoading) {
                  return Center(
                    child: IZILoading().isLoadingKit,
                  );
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    vertical: IZIDimensions.SPACE_SIZE_5X,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //Chủ đề câu hỏi
                        Obx(() => _contentDetailQuotation(
                              "topic_question".tr,
                              controller.questionResponse.value.idSubSpecialize!.name.toString(),
                            )),

                        //Hashtag
                        Obx(() => _contentDetailQuotation(
                              "Hashtag",
                              controller.questionResponse.value.hashTag.toString(),
                            )),

                        //Nội dung câu hỏi
                        Obx(() => _contentDetailQuotation(
                              "Detail_quotes_1".tr,
                              controller.questionResponse.value.content.toString(),
                            )),

                        //Thời gian thực hiện cuộc gọi
                        Obx(() => _contentDetailQuotation(
                              "Detail_quotes_2".tr,
                              "${controller.formatSecondToMinutes(controller.questionResponse.value.totalTime!)} ${"Detail_quotes_3".tr} ${IZIDate.formatDate(controller.questionResponse.value.updatedAt!.toLocal(), format: "HH:mm dd/MM/yyyy")}",
                            )),

                        //Chi phí đã báo giá
                        Obx(() => _contentDetailQuotation(
                              "Detail_quotes_4".tr,
                              "${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.genCostQuoted()))}VNĐ",
                              colorSubTitle: ColorResources.priceColor,
                            )),

                        //Trạng thái
                        Obx(() => _statusQuestion(
                              "status".tr,
                              controller.genStatusSelected(),
                            )),

                        //_inforQuestionCreator
                        Obx(() => _inforQuestionCreator(controller)),

                        //Button
                        Obx(() {
                          if (controller.questionResponse.value.statusQuestion == COMPLETED && controller.genBoolStatusButton() == true && controller.questionResponse.value.partnerSharePrice == -1) {
                            return IZIButton(
                              withBorder: IZIDimensions.ONE_UNIT_SIZE * 2,
                              onTap: () {
                                controller.goToShareScreen(idQuestion: controller.questionResponse.value.id.toString());
                              },
                              label: "share".tr,
                              colorBG: ColorResources.CALL_VIDEO,
                              borderRadius: IZIDimensions.BORDER_RADIUS_7X,
                            );
                          } else if (controller.questionResponse.value.statusQuestion == CONNECTING && controller.genBoolStatusButton() == false) {
                            return IZIButton(
                              withBorder: IZIDimensions.ONE_UNIT_SIZE * 2,
                              type: IZIButtonType.OUTLINE,
                              colorText: ColorResources.PRIMARY_APP,
                              onTap: () {
                                controller.deleteUserInAnswerList();
                              },
                              label: "Detail_quotes_5".tr,
                              borderRadius: IZIDimensions.BORDER_RADIUS_7X,
                            );
                          } else if (controller.questionResponse.value.statusQuestion == SELECTED_PERSON && controller.genBoolStatusButton() == true) {
                            return IZIButton(
                              withBorder: IZIDimensions.ONE_UNIT_SIZE * 2,
                              onTap: () {
                                controller.goToCallScreenPage();
                              },
                              label: "Make_call".tr,
                              borderRadius: IZIDimensions.BORDER_RADIUS_7X,
                            );
                          } else if (controller.questionResponse.value.statusQuestion == CALLED && controller.genBoolStatusButton() == true) {
                            return IZIButton(
                              withBorder: IZIDimensions.ONE_UNIT_SIZE * 2,
                              onTap: () {
                                controller.goToCallScreenPage();
                              },
                              label: "call_again".tr,
                              borderRadius: IZIDimensions.BORDER_RADIUS_7X,
                            );
                          }

                          return const SizedBox();
                        })
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  ///
  /// thông tin người tạo câu hỏi
  ///
  Widget _inforQuestionCreator(DetailQuotationController controller) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_1X,
            ),
            child: Text(
              "Detail_quotes_6".tr,
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                color: ColorResources.TITLE,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.onGoToViewProfileUserCreateQues(idUser: controller.questionResponse.value.idUser!.id.toString());
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_3X),
                  width: IZISize.size.width,
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    border: Border.all(width: IZIDimensions.ONE_UNIT_SIZE * 2, color: ColorResources.BORDER),
                    borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_6X),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
                    child: Row(
                      children: [
                        ClipOval(
                          child: IZIImage(
                            !IZIValidate.nullOrEmpty(controller.questionResponse.value.idUser!.avatar) ? controller.questionResponse.value.idUser!.avatar.toString() : ImagesPath.logo_haqua,
                            width: IZIDimensions.ONE_UNIT_SIZE * 120,
                            height: IZIDimensions.ONE_UNIT_SIZE * 120,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: IZIDimensions.ONE_UNIT_SIZE * 37),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_1X),
                                child: Text(
                                  controller.questionResponse.value.idUser!.fullName.toString(),
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    color: ColorResources.TITLE,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                controller.genStringAddress(
                                  controller.questionResponse.value.idUser!.address,
                                  controller.questionResponse.value.idUser!.idProvince,
                                  controller.questionResponse.value.idUser!.nation,
                                ),
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  color: ColorResources.SUBTITLE,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.PRIMARY_APP,
                      // borderRadius: BorderRadius.circular(
                      //     IZIDimensions.BORDER_RADIUS_7X)
                    ),
                    child: IconButton(
                      onPressed: () {
                        controller.onGoToViewProfileUserCreateQues(idUser: controller.questionResponse.value.idUser!.id.toString());
                      },
                      icon: Icon(
                        Platform.isIOS ? Icons.arrow_forward_ios : Icons.arrow_forward,
                        color: ColorResources.WHITE,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///nội dung câu hỏi báo giá
  ///
  Widget _contentDetailQuotation(
    String title,
    String content, {
    Color colorSubTitle = ColorResources.SUBTITLE,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_1X,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                color: ColorResources.TITLE,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
              color: colorSubTitle,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///nội dung câu hỏi báo giá
  ///
  Widget _statusQuestion(
    String title,
    Widget child,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_1X,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                color: ColorResources.TITLE,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
