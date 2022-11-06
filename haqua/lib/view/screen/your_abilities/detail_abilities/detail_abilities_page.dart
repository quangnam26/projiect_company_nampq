import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/view/screen/your_abilities/detail_abilities/detail_abilities_controller.dart';
import '../../../../base_widget/izi_loading.dart';
import '../../../../helper/izi_date.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../utils/color_resources.dart';

class DetailAbilitiesPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: IZIDimensions.iziSize.width,
        height: IZIDimensions.iziSize.height,
        child: GetBuilder(
          init: DetailAbilitiesController(),
          builder: (DetailAbilitiesController controller) {
            if (controller.isLoading) {
              return Center(
                child: IZILoading().isLoadingKit,
              );
            }
            return Obx(
              () => SizedBox(
                width: IZIDimensions.iziSize.width,
                height: IZIDimensions.iziSize.height,
                child: Stack(
                  children: [
                    /// Banner.
                    IZIImage(
                      controller.certificateResponse.value.banner.toString(),
                      width: IZIDimensions.iziSize.width,
                      height: IZIDimensions.iziSize.height * .4,
                    ),

                    /// Detail abilities quiz.
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: IZIDimensions.iziSize.width,
                        height: IZIDimensions.iziSize.height * .7,
                        decoration: BoxDecoration(
                          color: ColorResources.WHITE,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(IZIDimensions.ONE_UNIT_SIZE * 50),
                            topRight: Radius.circular(IZIDimensions.ONE_UNIT_SIZE * 50),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: IZIDimensions.SPACE_SIZE_5X,
                                    bottom: IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RatingBar.builder(
                                        glowColor: ColorResources.STAR_COLOR,
                                        unratedColor: Colors.black.withOpacity(.4),
                                        ignoreGestures: true,
                                        initialRating: controller.certificateResponse.value.level!,
                                        minRating: 1,
                                        itemSize: IZIDimensions.ONE_UNIT_SIZE * 50,
                                        allowHalfRating: true,
                                        itemPadding: EdgeInsets.symmetric(
                                          horizontal: IZIDimensions.SPACE_SIZE_1X,
                                        ),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: ColorResources.STAR_COLOR,
                                          size: IZIDimensions.ONE_UNIT_SIZE * 50,
                                        ),
                                        onRatingUpdate: (rataing) {},
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                        color: ColorResources.BLACK,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Lĩnh vực: ',
                                        ),
                                        TextSpan(
                                          text: controller.certificateResponse.value.idSubSpecialize!.name.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                        color: ColorResources.BLACK,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Thời gian: ',
                                        ),
                                        TextSpan(
                                          text: '${IZIDate.formatTimeFromDuration(Duration(seconds: controller.certificateResponse.value.timeOut!))} phút',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  child: Text(
                                    controller.certificateResponse.value.title.toString(),
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      fontWeight: FontWeight.w600,
                                      color: ColorResources.BLACK,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  controller.certificateResponse.value.content.toString(),
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    color: ColorResources.BLACK,
                                  ),
                                ),

                                /// My History quiz.
                                Obx(() {
                                  if (!IZIValidate.nullOrEmpty(controller.historyResponses.value.id)) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_3X),
                                          width: IZIDimensions.iziSize.width,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: IZIDimensions.ONE_UNIT_SIZE * .5,
                                                  color: ColorResources.GREY,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: IZIDimensions.SPACE_SIZE_1X,
                                                ),
                                                child: Text(
                                                  'Điểm của bạn',
                                                  style: TextStyle(
                                                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: IZIDimensions.ONE_UNIT_SIZE * .5,
                                                  color: ColorResources.GREY,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: IZIDimensions.SPACE_SIZE_2X,
                                          ),
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              style: TextStyle(
                                                fontSize: IZIDimensions.FONT_SIZE_H6,
                                                color: ColorResources.BLACK,
                                              ),
                                              children: [
                                                const TextSpan(
                                                  text: 'Họ & tên: ',
                                                ),
                                                WidgetSpan(
                                                  child: Obx(
                                                    () => Text(
                                                      controller.fullNameUser.value,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                                        color: ColorResources.BLACK,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: IZIDimensions.SPACE_SIZE_2X,
                                          ),
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              style: TextStyle(
                                                fontSize: IZIDimensions.FONT_SIZE_H6,
                                                color: ColorResources.BLACK,
                                              ),
                                              children: [
                                                const TextSpan(
                                                  text: 'Phần trăm điểm số: ',
                                                ),
                                                TextSpan(
                                                  text: '${controller.historyResponses.value.percent!.toStringAsFixed(0)} / 100%',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            style: TextStyle(
                                              fontSize: IZIDimensions.FONT_SIZE_H6,
                                              color: ColorResources.BLACK,
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: 'Số lần thi: ',
                                              ),
                                              TextSpan(
                                                text: '${controller.historyResponses.value.numberTest.toString()} lần',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return SizedBox(
                                    height: IZIDimensions.SPACE_SIZE_2X,
                                  );
                                }),

                                /// Button start quiz.
                                Obx(() {
                                  if (IZIValidate.nullOrEmpty(controller.historyResponses.value.id)) {
                                    return IZIButton(
                                      width: IZIDimensions.iziSize.width,
                                      label: "Trở về",
                                      onTap: () {
                                        controller.getBack();
                                      },
                                    );
                                  }
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_3X),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IZIButton(
                                          width: IZIDimensions.iziSize.width * .4,
                                          type: IZIButtonType.OUTLINE,
                                          label: "Trở về",
                                          onTap: () {
                                            controller.getBack();
                                          },
                                        ),
                                        IZIButton(
                                          width: IZIDimensions.iziSize.width * .4,
                                          label: "Bắt đầu thi",
                                          onTap: () {
                                            controller.showStartContest();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// Icon back.
                    Positioned(
                      left: IZIDimensions.SPACE_SIZE_2X,
                      top: IZIDimensions.ONE_UNIT_SIZE * 60,
                      child: IconButton(
                        onPressed: () {
                          controller.getBack();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: IZIDimensions.ONE_UNIT_SIZE * 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
