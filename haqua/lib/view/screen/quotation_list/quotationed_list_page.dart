import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:template/base_widget/background/background_premium.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_smart_refresher.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/quotation_list/quotation_list_controller.dart';

class QuotationedListPage extends GetView<QuotationListController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundApp(),
      appBar: IZIAppBar(
        colorTitle: ColorResources.WHITE,
        colorIconBack: ColorResources.WHITE,
        title: 'Quoted_Question'.tr,
      ),
      body: SizedBox(
        width: IZIDimensions.iziSize.width,
        height: IZIDimensions.iziSize.height,
        child: GetBuilder<QuotationListController>(
            init: QuotationListController(),
            builder: (QuotationListController controller) {
              if (controller.isLoading) {
                return Center(
                  child: IZILoading().isLoadingKit,
                );
              }
              return Column(
                children: [
                  /// TabBar.
                  Container(
                    width: IZIDimensions.iziSize.width,
                    height: IZIDimensions.iziSize.height * .06,
                    decoration: const BoxDecoration(
                      color: ColorResources.WHITE,
                    ),
                    child: SingleChildScrollView(
                      controller: controller.autoScrollController,
                      scrollDirection: Axis.horizontal,
                      child: Obx(() => Row(
                            children: [
                              ...List.generate(
                                controller.tabBarStringList.length,
                                (index) => AutoScrollTag(
                                  key: ValueKey(index),
                                  controller: controller.autoScrollController!,
                                  index: index,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.selectIndexTabBar(index);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: IZIDimensions.ONE_UNIT_SIZE * 20,
                                        vertical: IZIDimensions.ONE_UNIT_SIZE * 5,
                                      ),
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ColorResources.WHITE,
                                        border: Border(
                                          bottom: controller.currentIndexTabBar.value == index
                                              ? BorderSide(
                                                  width: IZIDimensions.ONE_UNIT_SIZE * 3,
                                                  color: ColorResources.PRIMARY_APP,
                                                )
                                              : BorderSide.none,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          controller.tabBarStringList[index].toString(),
                                          style: TextStyle(
                                            color: controller.currentIndexTabBar.value == index ? ColorResources.PRIMARY_APP : ColorResources.GREY,
                                            fontWeight: controller.currentIndexTabBar.value == index ? FontWeight.w600 : FontWeight.normal,
                                            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    child: Obx(() => IZISmartRefresher(
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
                                  controller.goToDetailQuestionQuoted(
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
                                                Text(
                                                  "${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.questionResponseList[index].moneyTo.toString()))}VNĐ",
                                                  style: TextStyle(
                                                    color: ColorResources.RED,
                                                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (controller.currentIndexTabBar.value == 0)
                                              Container(
                                                margin: EdgeInsets.only(
                                                  top: IZIDimensions.SPACE_SIZE_1X,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    controller.genStatusSelected(questionResponse: controller.questionResponseList[index]),
                                                  ],
                                                ),
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
                        )),
                  )
                ],
              );
            }),
      ),
    );
  }
}
