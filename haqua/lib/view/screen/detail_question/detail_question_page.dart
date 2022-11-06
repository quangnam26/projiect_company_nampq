import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_premium.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_box_image.dart';
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
import 'package:template/view/screen/detail_question/detail_question_controller.dart';

class DetailQuestionPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundApp(),
      appBar: IZIAppBar(
        title: "Answer_question".tr,
      ),
      body: GetBuilder(
        init: DetailQuestionController(),
        builder: (DetailQuestionController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return Obx(
            () => Container(
              color: ColorResources.BACKGROUND,
              width: IZIDimensions.iziSize.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// Info User
                    Container(
                      margin: EdgeInsets.only(
                        bottom: IZIDimensions.SPACE_SIZE_5X,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Avatar User
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              0,
                              IZIDimensions.SPACE_SIZE_5X,
                              0,
                              IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                controller.goToPreviewImage(
                                  imageUrl: IZIValidate().getTypeAvatarString(controller.questionResponse.value.idUser!.avatar.toString()),
                                );
                              },
                              child: ClipOval(
                                child: IZIImage(
                                  IZIValidate().getTypeAvatarString(controller.questionResponse.value.idUser!.avatar.toString()),
                                  width: IZIDimensions.iziSize.width * .3,
                                  height: IZIDimensions.iziSize.width * .3,
                                ),
                              ),
                            ),
                          ),

                          ///  Name User
                          Container(
                            margin: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: Text(
                              controller.questionResponse.value.idUser!.fullName.toString(),
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                color: ColorResources.BLACK,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          /// Rating User
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: (controller.questionResponse.value.idUser!.statisticReview!.totalRating != 0 && controller.questionResponse.value.idUser!.statisticReview!.countRating != 0) ? (controller.questionResponse.value.idUser!.statisticReview!.totalRating! / controller.questionResponse.value.idUser!.statisticReview!.countRating!) : 0,
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
                    ),

                    /// Info Question
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        IZIDimensions.SPACE_SIZE_4X,
                        0,
                        IZIDimensions.SPACE_SIZE_4X,
                        IZIDimensions.SPACE_SIZE_5X,
                      ),
                      width: IZIDimensions.iziSize.width,
                      padding: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        border: Border.all(
                          width: IZIDimensions.ONE_UNIT_SIZE * 1,
                          color: ColorResources.GREY,
                        ),
                        borderRadius: BorderRadius.circular(
                          IZIDimensions.BLUR_RADIUS_3X,
                        ),
                      ),
                      child: Column(
                        children: [
                          /// Topic Question
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: IZIDimensions.ONE_UNIT_SIZE * 10,
                                  ),
                                  child: IZIImage(
                                    ImagesPath.logo_share_detail_question,
                                    color: ColorResources.PRIMARY_APP,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    controller.questionResponse.value.idSubSpecialize!.name.toString(),
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Date Question
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: IZIDimensions.ONE_UNIT_SIZE * 10,
                                  ),
                                  child: IZIImage(
                                    ImagesPath.logo_calendar_detail_question,
                                    color: ColorResources.PRIMARY_APP,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    IZIDate.formatDate(controller.questionResponse.value.createdAt!, format: 'EEE, dd/MM/yyyy'),
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Time Question
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: IZIDimensions.ONE_UNIT_SIZE * 10,
                                  ),
                                  child: IZIImage(
                                    ImagesPath.logo_clock_detail_question,
                                    color: ColorResources.PRIMARY_APP,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "30 ${'minute'.tr}",
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Money Question
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: IZIDimensions.ONE_UNIT_SIZE * 10,
                                ),
                                child: IZIImage(
                                  ImagesPath.logo_dollar_detail_question,
                                  color: ColorResources.PRIMARY_APP,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  (controller.questionResponse.value.moneyFrom != 0 && controller.questionResponse.value.moneyTo != 0) ? "${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.questionResponse.value.moneyFrom))}vnđ - ${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.questionResponse.value.moneyTo))}vnđ" : "Miễn phí",
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// Detail Question
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        IZIDimensions.SPACE_SIZE_4X,
                        0,
                        IZIDimensions.SPACE_SIZE_4X,
                        SPACE_BOTTOM_SHEET,
                      ),
                      width: IZIDimensions.iziSize.width,
                      padding: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        border: Border.all(
                          width: IZIDimensions.ONE_UNIT_SIZE * 1,
                          color: ColorResources.GREY,
                        ),
                        borderRadius: BorderRadius.circular(
                          IZIDimensions.BLUR_RADIUS_3X,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Detail question.
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            child: Text(
                              "Question_details".tr,
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          /// Content Question
                          Text(
                            controller.questionResponse.value.content.toString(),
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                            ),
                          ),

                          /// Download files
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            child: _files(controller),
                          ),

                          /// View images
                          if (!IZIValidate.nullOrEmpty(controller.questionResponse.value.attachImages)) _images(controller),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      widgetBottomSheet: GetBuilder(
        init: DetailQuestionController(),
        builder: (DetailQuestionController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return controller.genBoolButton() == true
              ?
              //Button accept.
              _button(controller)
              : const SizedBox();
        },
      ),
    );
  }

  ///
  /// Download files.
  ///
  Widget _files(DetailQuestionController controller) {
    if (IZIValidate.nullOrEmpty(controller.questionResponse.value.attachFiles)) {
      return const SizedBox();
    }
    return Wrap(
      children: List.generate(
        controller.questionResponse.value.attachFiles!.length,
        (index) {
          return GestureDetector(
            onTap: () async {
              controller.downloadFiles(urlFiles: controller.questionResponse.value.attachFiles![index].toString());
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(
                0,
                IZIDimensions.SPACE_SIZE_2X,
                IZIDimensions.SPACE_SIZE_2X,
                0,
              ),
              width: IZIDimensions.iziSize.width * .3,
              padding: EdgeInsets.all(
                IZIDimensions.SPACE_SIZE_2X,
              ),
              decoration: BoxDecoration(
                color: ColorResources.LIGHT_GREY.withOpacity(.2),
                border: Border.all(
                  width: IZIDimensions.ONE_UNIT_SIZE * 2,
                  color: ColorResources.PRIMARY_BLUE_APP,
                ),
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BLUR_RADIUS_2X,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      controller.questionResponse.value.attachFiles![index].toString().split('/').last,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
                    Icons.cloud_download_outlined,
                    color: ColorResources.PRIMARY_BLUE_APP,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// View images.
  ///
  Column _images(DetailQuestionController controller) {
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
        IZIBoxImage(
          images: controller.questionResponse.value.attachImages!.map<String>((e) => e.toString()).toList(),
          onDelete: (val, values) {},
          onPress: () {},
          onPreviewImages: (val, values) {
            controller.goToPreviewImage(imageUrl: val);
          },
        ),
      ],
    );
  }

  ///
  /// Accept button.
  ///
  Widget _button(DetailQuestionController controller) {
    return Obx(
      () => IZIButton(
        margin: EdgeInsets.fromLTRB(
          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
          0,
          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
          IZIDimensions.SPACE_SIZE_2X,
        ),
        onTap: () {
          controller.showDialogAuction();
        },
        isEnabled: controller.genBoolButton(),
        label: "I_answer_question".tr,
      ),
    );
  }
}
