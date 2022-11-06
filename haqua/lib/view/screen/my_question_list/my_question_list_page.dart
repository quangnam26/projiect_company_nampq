import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_premium.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_smart_refresher.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/my_question_list/my_question_list_controller.dart';

class MyQuestionListPage extends GetView {
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
          title: "Question_posted".tr,
        ),
        body: SizedBox(
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.iziSize.height,
          child: GetBuilder(
            init: MyQuestionListController(),
            builder: (MyQuestionListController controller) {
              if (controller.isLoading) {
                return Center(
                  child: IZILoading().isLoadingKit,
                );
              }
              return Obx(() => IZISmartRefresher(
                    refreshController: controller.refreshController,
                    onLoading: controller.onLoadingData,
                    onRefresh: controller.onRefreshData,
                    enablePullDown: true,
                    enablePullUp: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.questionResponseList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.goToDetailQuestion(
                              idQuestion: controller.questionResponseList[index].id.toString(),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              index == 0 ? IZIDimensions.SPACE_SIZE_2X : 0,
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              IZIDimensions.SPACE_SIZE_2X,
                            ),
                            width: IZIDimensions.iziSize.width,
                            decoration: BoxDecoration(
                              color: ColorResources.WHITE,
                              border: Border.all(
                                color: ColorResources.PRIMARY_APP,
                              ),
                              borderRadius: BorderRadius.circular(
                                IZIDimensions.BORDER_RADIUS_5X,
                              ),
                            ),
                            padding: EdgeInsets.all(
                              IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    right: IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  child: ClipOval(
                                    child: IZIImage(
                                      !IZIValidate.nullOrEmpty(controller.questionResponseList[index].attachImages) ? controller.questionResponseList[index].attachImages!.first.toString() : ImagesPath.logo_haqua,
                                      width: IZIDimensions.ONE_UNIT_SIZE * 100,
                                      height: IZIDimensions.ONE_UNIT_SIZE * 100,
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
                                          controller.questionResponseList[index].content.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: ColorResources.BLACK,
                                            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              IZIDate.formatDate(
                                                controller.questionResponseList[index].createdAt!.toLocal(),
                                                format: 'HH:mm dd-MM-yyyy',
                                              ),
                                              style: TextStyle(
                                                color: ColorResources.BLACK.withOpacity(.8),
                                                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                              ),
                                            ),
                                          ),
                                          controller.genStatusQuestion(
                                            statusQuestion: controller.questionResponseList[index].statusQuestion.toString(),
                                            statusShare: controller.questionResponseList[index].statusShare.toString(),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
