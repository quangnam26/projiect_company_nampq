import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/category/category_controller.dart';
import 'package:template/view/screen/product_brands/product_brands_controller.dart';

class ProductBrandsPage extends GetView<ProductBrandsController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      // background: const BackgroundAppBar(),S
      appBar: IZIAppBar(
        title: 'Thương hiệu sản phẩm',
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.NEUTRALS_3,
          ),
        ),
      ),
      body: GetBuilder<ProductBrandsController>(
        init: ProductBrandsController(),
        builder: (ProductBrandsController controller) {
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
          return Column(
            children: [
              const Divider(
                height: 5,
                color: ColorResources.WHITE3,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SmartRefresher(
                        controller: controller.refreshController,
                        onRefresh: () {
                          controller.onRefreshData();
                        },
                        onLoading: () {
                          controller.onLoadingData();
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
                          idleText: "kéo lên để tải thêm dữ liệu",
                        ),
                        child: controller.listBrandResponse.isEmpty
                            ? SizedBox(
                                height: IZIDimensions.iziSize.height * 0.7,
                                child: Center(
                                  child: Text(
                                    'Không có dữ liệu',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: ColorResources.NEUTRALS_5,
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                // reverse: true,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: controller.listBrandResponse.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.isOntapImage(index);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: controller.selected == index
                                            ? ColorResources.WHITE
                                            : ColorResources.NEUTRALS_11,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 10,
                                            color: Colors.black12,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: IZIDimensions.SPACE_SIZE_3X,
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                IZIDimensions.BLUR_RADIUS_3X),
                                            child: IZIImage(
                                              controller
                                                      .listBrandResponse[index]
                                                      .image ??
                                                  "",
                                              height:
                                                  IZIDimensions.ONE_UNIT_SIZE *
                                                      100,
                                              width:
                                                  IZIDimensions.ONE_UNIT_SIZE *
                                                      100,
                                            ),
                                          ),
                                          SizedBox(
                                            height: IZIDimensions.SPACE_SIZE_3X,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: IZIDimensions
                                                    .SPACE_SIZE_2X),
                                            child: Text(
                                              controller
                                                      .listBrandResponse[index]
                                                      .name ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: TextStyle(
                                                color:
                                                    controller.selected == index
                                                        ? ColorResources.ORANGE
                                                        : ColorResources
                                                            .COLOR_BLACK_TEXT2,
                                                fontFamily: 'Roboto',
                                                fontSize:
                                                    IZIDimensions.FONT_SIZE_H6 *
                                                        0.9,
                                                fontWeight:
                                                    controller.selected == index
                                                        ? FontWeight.w400
                                                        : FontWeight.w400,
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
                    ),
                    Expanded(
                      flex: 7,
                      child: SmartRefresher(
                        controller: controller.refreshtrollerTow,
                        onRefresh: () {
                          controller.onRefreshDataProduct();
                        },
                        onLoading: () {
                          controller.onLoadingDataProduct();
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
                          idleText: "kéo lên để tải thêm dữ liệu",
                        ),

                        child: controller.listProductsResponse.isEmpty
                            ? SizedBox(
                                height: IZIDimensions.iziSize.height * 0.66,
                                child: Center(
                                  child: Text(
                                    "Không có dữ liệu",
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H5,
                                      color: ColorResources.NEUTRALS_5,
                                    ),
                                  ),
                                ),
                              )
                            : GridView.builder(
                                // physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.only(
                                    right: IZIDimensions.SPACE_SIZE_2X),
                                shrinkWrap: true,
                                itemCount:
                                    controller.listProductsResponse.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  // mainAxisSpacing: 10,
                                  // crossAxisSpacing: 7,
                                  mainAxisExtent:
                                      IZIDimensions.ONE_UNIT_SIZE * 175,
                                ),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.onTapProduct(
                                          proudct: controller
                                              .listProductsResponse[index]);
                                    },
                                    child: Container(
                                      color: ColorResources.NEUTRALS_11,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: IZIDimensions.SPACE_SIZE_3X,
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                IZIDimensions.BLUR_RADIUS_3X),
                                            child: SizedBox(
                                              height:
                                                  IZIDimensions.ONE_UNIT_SIZE *
                                                      80,
                                              width:
                                                  IZIDimensions.ONE_UNIT_SIZE *
                                                      80,
                                              child: IZIImage(controller
                                                      .listProductsResponse[
                                                          index]
                                                      .thumbnail ??
                                                  ""),
                                            ),
                                          ),
                                          SizedBox(
                                            height: IZIDimensions.SPACE_SIZE_2X,
                                          ),
                                          Text(
                                            controller
                                                    .listProductsResponse[index]
                                                    .name ??
                                                "",
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize:
                                                    IZIDimensions.FONT_SIZE_H6 *
                                                        0.8,
                                                fontWeight: FontWeight.w300,
                                                color: ColorResources
                                                    .COLOR_BLACK_TEXT),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                        // ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
