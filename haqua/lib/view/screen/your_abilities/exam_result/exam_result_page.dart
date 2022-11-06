import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/view/screen/your_abilities/exam_result/exam_result_controller.dart';
import '../../../../base_widget/izi_loading.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/images_path.dart';

class ExamResultPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND,
      body: GetBuilder(
        init: ExamResultController(),
        builder: (ExamResultController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return SizedBox(
            width: IZIDimensions.iziSize.width,
            height: IZIDimensions.iziSize.height,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN),
                  child: Column(
                    children: [
                      IZIImage(
                        ImagesPath.exam_result,
                        width: IZIDimensions.iziSize.width * .7,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_3X),
                        child: Text(
                          'CHÚC MƯNG BẠN ĐÃ HOÀN THÀNH BÀI THI',
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H5,
                            color: ColorResources.RED,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
                            decoration: const BoxDecoration(
                              color: ColorResources.PRIMARY_APP,
                              shape: BoxShape.circle,
                            ),
                            width: IZIDimensions.iziSize.width * .30,
                            height: IZIDimensions.iziSize.width * .30,
                            child: Center(
                              child: ClipOval(
                                child: IZIImage(
                                  !IZIValidate.nullOrEmpty(controller.userResponse!.avatar) ? controller.userResponse!.avatar.toString() : ImagesPath.logo_haqua,
                                  width: IZIDimensions.iziSize.width * .28,
                                  height: IZIDimensions.iziSize.width * .28,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_5X),
                            child: Text(
                              controller.userResponse!.fullName.toString(),
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                                fontWeight: FontWeight.w600,
                                color: ColorResources.BLACK,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_5X),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_5X),
                                  width: IZIDimensions.iziSize.width * .28,
                                  decoration: BoxDecoration(
                                    color: ColorResources.EXAM_RESULT_COLOR,
                                    borderRadius: BorderRadius.circular(IZIDimensions.BLUR_RADIUS_4X),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_1X),
                                        child: Text(
                                          controller.historyQuizResponse!.totalPoint.toString(),
                                          style: TextStyle(
                                            fontSize: IZIDimensions.FONT_SIZE_H5,
                                            color: ColorResources.WHITE,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Tổng câu',
                                        style: TextStyle(
                                          fontSize: IZIDimensions.FONT_SIZE_H6 * .8,
                                          color: ColorResources.WHITE,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_5X),
                                  width: IZIDimensions.iziSize.width * .28,
                                  decoration: BoxDecoration(
                                    color: ColorResources.EXAM_RESULT_COLOR,
                                    borderRadius: BorderRadius.circular(IZIDimensions.BLUR_RADIUS_4X),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_1X),
                                        child: Text(
                                          controller.historyQuizResponse!.point.toString(),
                                          style: TextStyle(
                                            fontSize: IZIDimensions.FONT_SIZE_H5,
                                            color: ColorResources.WHITE,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Tổng câu đúng',
                                        style: TextStyle(
                                          fontSize: IZIDimensions.FONT_SIZE_H6 * .8,
                                          color: ColorResources.WHITE,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_5X),
                                  width: IZIDimensions.iziSize.width * .28,
                                  decoration: BoxDecoration(
                                    color: ColorResources.EXAM_RESULT_COLOR,
                                    borderRadius: BorderRadius.circular(IZIDimensions.BLUR_RADIUS_4X),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_1X),
                                        child: Text(
                                          (controller.historyQuizResponse!.totalPoint! - controller.historyQuizResponse!.point!).toString(),
                                          style: TextStyle(
                                            fontSize: IZIDimensions.FONT_SIZE_H5,
                                            color: ColorResources.WHITE,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Tổng câu sai',
                                        style: TextStyle(
                                          fontSize: IZIDimensions.FONT_SIZE_H6 * .8,
                                          color: ColorResources.WHITE,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_5X),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_1X),
                                      child: Text(
                                        '${controller.historyQuizResponse!.percent!.toStringAsFixed(0)} / 100%',
                                        style: TextStyle(
                                          fontSize: IZIDimensions.FONT_SIZE_H6,
                                          color: ColorResources.BLACK,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Tỉ lệ',
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                        color: ColorResources.BLACK,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_5X),
                                  color: ColorResources.BLACK.withOpacity(.8),
                                  height: IZIDimensions.ONE_UNIT_SIZE * 130,
                                  width: IZIDimensions.ONE_UNIT_SIZE * 3,
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_1X),
                                      child: Text(
                                        controller.historyQuizResponse!.numberTest.toString(),
                                        style: TextStyle(
                                          fontSize: IZIDimensions.FONT_SIZE_H6,
                                          color: ColorResources.BLACK,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Số lần thi',
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                        color: ColorResources.BLACK,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IZIButton(
                            label: 'Hoàn thành',
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
