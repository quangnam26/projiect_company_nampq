import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/routes/route_path/Search_Results_Routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/favoriteproducts/favorite_products_controller.dart';
import '../../../../base_widget/background/backround_appbar.dart';
import '../../../../base_widget/izi_input.dart';
import '../../../../helper/izi_price.dart';

class FavoriteProductsPage extends GetView<FavoriteProductsController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
          title: 'Sản phẩm yêu thích',
          iconBack: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorResources.NEUTRALS_3,
            ),
          )),
      body: GetBuilder(
        init: FavoriteProductsController(),
        builder: (FavoriteProductsController controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: IZIDimensions.SPACE_SIZE_4X * 1.2,
                    left: IZIDimensions.SPACE_SIZE_3X,
                    right: IZIDimensions.SPACE_SIZE_3X,
                    bottom: IZIDimensions.SPACE_SIZE_3X),
                child: appBar(context, controller),
              ),
              Expanded(
                child: Container(
                  // height: IZIDimensions.iziSize.height,
                  margin: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_1X,
                      right: IZIDimensions.SPACE_SIZE_1X),
                  color: ColorResources.NEUTRALS_11,
                  padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_2X),
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    onRefresh: () {
                      controller.onRefreshData();
                    },
                    onLoading: () {
                      controller.onLoadingData();
                    },
                    enablePullUp: true,
                    // enablePullDown: true,
                    header: const ClassicHeader(
                      idleText: "Kéo xuống để làm mới dữ liệu",
                      releaseText: "Thả ra để làm mới dữ liệu",
                      completeText: "Làm mới dữ liệu thành công",
                      refreshingText: "Đang làm mới dữ liệu",
                      failedText: "Làm mới dữ liệu bị lỗi",
                      canTwoLevelText: "Thả ra để làm mới dữ liệu",
                    ),
                    footer: const ClassicFooter(
                      loadingText: "Đang tải...",
                      noDataText: "Không có thêm dữ liệu",
                      canLoadingText: "Kéo lên để tải thêm dữ liệu",
                      failedText: "Tải thêm dữ liệu bị lỗi",
                      idleText: "",
                      idleIcon: null,
                    ),

                    child: controller.listProducts.isEmpty
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
                        : IZIListView(
                            mainAxisSpacing: 15,
                            mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 450,
                            crossAxisSpacing: 15,
                            type: IZIListViewType.GRIDVIEW,
                            itemCount: controller.listProducts.length,
                            builder: (index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.onTapProduct(
                                      product: controller.listProducts[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(
                                      IZIDimensions.SPACE_SIZE_3X),
                                  width: IZIDimensions.ONE_UNIT_SIZE * 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        IZIDimensions.BLUR_RADIUS_2X),
                                    color: ColorResources.WHITE,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: IZIDimensions
                                                    .SPACE_SIZE_1X),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              child: SizedBox(
                                                height: IZIDimensions
                                                        .ONE_UNIT_SIZE *
                                                    220,
                                                width: IZIDimensions
                                                        .ONE_UNIT_SIZE *
                                                    250,
                                                child: IZIImage(controller
                                                    .listProducts[index]
                                                    .thumbnail!
                                                    .toString()),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: IZIDimensions
                                                      .SPACE_SIZE_1X,
                                                  horizontal: IZIDimensions
                                                      .SPACE_SIZE_2X),
                                              decoration: BoxDecoration(
                                                color: ColorResources.WHITE,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        IZIDimensions
                                                            .BORDER_RADIUS_7X),
                                                border: Border.all(
                                                  width: 1.5,
                                                  color: ColorResources.ORANGE,
                                                ),
                                              ),
                                              child: IZIText(
                                                text:
                                                    "${controller.listProducts[index].discountPercent}% OFF",
                                                style: TextStyle(
                                                    fontSize: IZIDimensions
                                                            .FONT_SIZE_H6 *
                                                        0.8,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    color:
                                                        ColorResources.ORANGE),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical:
                                                IZIDimensions.SPACE_SIZE_2X),
                                        child: IZIText(
                                          text: controller
                                              .listProducts[index].name
                                              .toString(),
                                          maxLine: 2,
                                          style: TextStyle(
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6 *
                                                      0.9,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              color: ColorResources.PRIMARY_2),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: IZIDimensions.SPACE_SIZE_3X),
                                        child: IZIText(
                                          text:
                                              "đ ${IZIPrice.currencyConverterVND(double.parse(controller.listProducts[index].price.toString()))} ",
                                          style: TextStyle(
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              color: ColorResources.RED),
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(
                                            top: IZIDimensions.SPACE_SIZE_2X),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: ColorResources
                                                      .YELLOW_PRIMARY2,
                                                ),
                                                IZIText(
                                                  text:
                                                      "${double.parse((controller.listProducts[index].totalPoint! / controller.listProducts[index].countRate!).toString()).toStringAsFixed(1)} (${controller.listProducts[index].totalPoint!})",
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: IZIDimensions
                                                            .FONT_SIZE_H6 *
                                                        0.8,
                                                    fontWeight: FontWeight.w400,
                                                    color: ColorResources
                                                        .PRIMARY_7,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: IZIDimensions
                                                      .SPACE_SIZE_1X),
                                              child: IZIText(
                                                text:
                                                    "${controller.listProducts[index].countSold} đã bán",
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: IZIDimensions
                                                          .FONT_SIZE_H6 *
                                                      0.8,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      ColorResources.PRIMARY_7,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // FittedBox(
                                      //   child: Container(
                                      //     margin: EdgeInsets.only(
                                      //         top: IZIDimensions.SPACE_SIZE_2X),
                                      //     child: Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.spaceBetween,
                                      //       children: [
                                      //         Row(
                                      //           children: [
                                      //             const Icon(
                                      //               Icons.star,
                                      //               color: ColorResources
                                      //                   .YELLOW_PRIMARY2,
                                      //               size: 20,
                                      //             ),
                                      //             IZIText(
                                      //               text:
                                      //                   "${double.parse((controller.listProducts[index].totalPoint! / controller.listProducts[index].countRate!).toString()).toStringAsFixed(1)} (${controller.listProducts[index].totalPoint!})",
                                      //               style: TextStyle(
                                      //                   fontSize: IZIDimensions
                                      //                           .FONT_SIZE_H6 *
                                      //                       0.7,
                                      //                   fontWeight:
                                      //                       FontWeight.w400,
                                      //                   fontStyle:
                                      //                       FontStyle.normal,
                                      //                   color: ColorResources
                                      //                       .PRIMARY_7,
                                      //                   fontFamily: 'Roboto'),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //         SizedBox(
                                      //           width:
                                      //               IZIDimensions.SPACE_SIZE_2X,
                                      //         ),
                                      //         IZIText(
                                      //           text:
                                      //               "${controller.listProducts[index].countSold} đã bán",
                                      //           style: TextStyle(
                                      //             fontSize: IZIDimensions
                                      //                     .FONT_SIZE_H6 *
                                      //                 0.8,
                                      //             fontFamily: 'Roboto ',
                                      //             fontWeight: FontWeight.w400,
                                      //             fontStyle: FontStyle.normal,
                                      //             color:
                                      //                 ColorResources.PRIMARY_7,
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  ///
  /// appbar
  ///
  Widget appBar(BuildContext context, FavoriteProductsController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            child: searchInput(
              context,
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_1X),
          child: GestureDetector(
            onTap: () {
              controller.onChangeIsSort();
            },
            child: controller.isShort
                ? const Icon(
                    Icons.arrow_upward,
                    size: 35,
                    color: Colors.orange,
                  )
                : const Icon(
                    Icons.arrow_downward,
                    color: Colors.orange,
                    size: 35,
                  ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(SearchResultsRoutes.SEARCH_FILTER);
          },
          child: const Icon(
            Icons.filter_alt_outlined,
            size: 40,
            color: ColorResources.ORANGE,
          ),
        ),
      ],
    );
  }

  ///
  /// Search
  ///
  Widget searchInput(BuildContext context) {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: 'Nhập vào tên sản phẩm',
      // disbleError: true,
      style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8),
      isBorder: true,
      borderSide: const BorderSide(color: ColorResources.WHITE),
      hintStyle: const TextStyle(color: ColorResources.NEUTRALS_5),

      prefixIcon: (val) {
        // controller.searchByName();
        return const Icon(
          Icons.search,
          color: ColorResources.ORANGE5,
          size: 24,
        );
      },

      fillColor: ColorResources.WHITE,
      // borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
      onChanged: (val) {
        controller.searchTerm = val;
        controller.searchByName();
        print("kiki $val");
      },
      onTap: (val) {
        controller.searchTerm = val.toString();
        controller.searchByName();
        print("lala$val");
      },
      onSubmitted: (val) {
        controller.searchByName();
        print("kate $val");
      },
    );
  }

  //todo thiếu lọc

}
