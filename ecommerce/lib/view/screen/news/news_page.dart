import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/view/screen/news/customTabbar.dart';
import 'package:template/view/screen/news/new_controller.dart';
import '../../../base_widget/background/backround_appbar.dart';
import '../../../base_widget/izi_app_bar.dart';
import '../../../base_widget/izi_image.dart';
import '../../../utils/color_resources.dart';

class NewsPage extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      safeAreaBottom: false,
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: const IZIAppBar(
        title: "Tin tức",
      ),
      body: GetBuilder(
        init: NewsController(),
        builder: (NewsController controller) {
          if (controller.isloading) {
            return SizedBox(
              height: IZIDimensions.iziSize.height * 0.8,
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.ORANGE,
                ),
              ),
            );
          }
          return Container(
            color: ColorResources.NEUTRALS_15,
            child: Column(
              children: [
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_4X,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_4X * 1.3,
                  ),
                  child: CustomTabbar(
                    radiusTabBar: 12,
                    isUnderLine: false,
                    colorTabBar: ColorResources.YELLOW2,
                    colorUnderLine: ColorResources.ORANGE,
                    colorText: ColorResources.ORANGE,
                    currentIndex: controller.postion,
                    items: controller.listNewsCategoryResponse,
                    onTapChangedTabbar: (int v) {
                      controller.selectIndexTabbar(v);
                    },
                  ),
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_2X,
                ),
                // ignore: prefer_if_elements_to_conditional_expressions
                Expanded(
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    onRefresh: () {
                      controller.onRefreshData("");
                    },
                    onLoading: () {
                      controller.onLoadingData("");
                    },
                    enablePullUp: true,
                    header: const ClassicHeader(
                        idleText: "kéo xuống để làm mới dữ liệu",
                        releaseText: "thả ra để làm mới dữ liệu",
                        completeText: "làm mới dữ liệu thành công",
                        refreshingText: "đang làm mới dữ liệu",
                        failedText: "làm mới dữ liệu bị lỗi",
                        canTwoLevelText: "thả ra để làm mới dữ liệu"),
                    footer: const ClassicFooter(
                        loadingText: "đang tải",
                        noDataText: "không có thêm dữ liệu",
                        canLoadingText: "kéo lên để tải thêm dữ liệu",
                        failedText: "tải thêm dữ liệu bị lỗi",
                        idleText: "kéo lên để tải thêm dữ liệu"),
                    child: controller.listNewsResponse.isEmpty
                        ? SizedBox(
                            height: IZIDimensions.iziSize.height * 0.7,
                            child: Center(
                              child: Text(
                                'Không có dữ liệu',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: ColorResources.NEUTRALS_17,
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              top: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            itemCount: controller.listNewsResponse.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.gotoSDetailedNews(
                                    controller.listNewsResponse[index].id,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: IZIDimensions.SPACE_SIZE_4X * 1.3,
                                    right: IZIDimensions.SPACE_SIZE_4X * 1.3,
                                    bottom: IZIDimensions.SPACE_SIZE_3X,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorResources.WHITE,
                                    borderRadius: BorderRadius.circular(
                                      IZIDimensions.BLUR_RADIUS_4X,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: IZIDimensions.SPACE_SIZE_3X *
                                                1.3,
                                            right: IZIDimensions.SPACE_SIZE_3X *
                                                1.3,
                                            top: IZIDimensions.SPACE_SIZE_3X *
                                                1.3,
                                            bottom:
                                                IZIDimensions.SPACE_SIZE_1X),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                IZIDimensions.BLUR_RADIUS_2X),
                                            child: IZIImage(
                                              controller.listNewsResponse[index]
                                                      .image ??
                                                  '',
                                              width:
                                                  IZIDimensions.iziSize.width,
                                              height:
                                                  IZIDimensions.ONE_UNIT_SIZE *
                                                      200,
                                            )
                                            // : Text("không có dữ liệu"),
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: IZIDimensions.SPACE_SIZE_3X *
                                                1.5,
                                            bottom:
                                                IZIDimensions.SPACE_SIZE_1X),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              CupertinoIcons.calendar,
                                              color: ColorResources.GREY,
                                              size: 22,
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              IZIDate.dateFormatUtc(controller
                                                  .listNewsResponse[index]
                                                  .createdAt!),
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color:
                                                    ColorResources.NEUTRALS_17,
                                                fontSize:
                                                    IZIDimensions.FONT_SIZE_H6,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: IZIDimensions.SPACE_SIZE_3X *
                                                1.5,
                                            bottom: IZIDimensions.SPACE_SIZE_1X,
                                            right: IZIDimensions.SPACE_SIZE_3X *
                                                1.3),
                                        child: Text(
                                          controller.listNewsResponse[index]
                                                  .title ??
                                              "",
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: ColorResources
                                                .COLOR_BLACK_TEXT2,
                                            fontSize:
                                                IZIDimensions.FONT_SIZE_H6,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: IZIDimensions.SPACE_SIZE_3X *
                                                1.5,
                                            bottom:
                                                IZIDimensions.SPACE_SIZE_2X *
                                                    2),
                                        child: Text(
                                          controller.listNewsResponse[index]
                                                  .description ??
                                              "",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Roboto12',
                                            color: ColorResources
                                                .COLOR_BLACK_TEXT2,
                                            fontSize:
                                                IZIDimensions.FONT_SIZE_H6,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                )

                // )
              ],
            ),
          );
        },
      ),
    );
  }
}
