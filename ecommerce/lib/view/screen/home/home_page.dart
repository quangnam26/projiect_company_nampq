import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/background/background_white.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_slider.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/routes/route_path/category_routes.dart';
import 'package:template/routes/route_path/account_routes.dart';
import 'package:template/routes/route_path/detail_page_router.dart';
import 'package:template/routes/route_path/notification_routers.dart';
import 'package:template/routes/route_path/search_results_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/components/common_image_page.dart';
import 'package:template/view/screen/components/comom_item_view_page.dart';
import 'package:template/view/screen/components/display_listview_or_gridview.dart';
import '../../../base_widget/izi_input.dart';

import '../../../helper/izi_validate.dart';

import '../dash_board/dash_board_controller.dart';
import 'home_controller.dart';
import 'package:html/parser.dart' show parse;

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundWhite(),
      isSingleChildScrollView: false,
      body: GetBuilder(
        builder: (HomeController controller) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SizedBox(
              height: IZIDimensions.iziSize.height,
              width: IZIDimensions.iziSize.width,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      child: Column(
                        children: [
                          /// Appbar
                          appBar(context),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_4X,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    Expanded(
                      child: SmartRefresher(
                        controller: controller.refreshController,
                        onLoading: () {
                          controller.refreshController.loadNoData();
                          controller.refreshController.loadComplete();
                        },
                        onRefresh: () {
                          controller.onRefesh();
                          controller.refreshController.resetNoData();
                          controller.refreshController.refreshCompleted();
                        },
                        enablePullUp: true,
                        header: const ClassicHeader(
                          idleText: "Kéo xuống để làm mới dữ liệu",
                          releaseText: "Thả ra để làm mới dữ liệu",
                          completeText: "Làm mới dữ liệu thành công",
                          refreshingText: "Đang làm mới dữ liệu",
                          failedText: "Làm mới dữ liệu bị lỗi",
                          canTwoLevelText: "Thả ra để làm mới dữ liệu",
                        ),
                        footer: ClassicFooter(
                          loadingText: "Đang tải...",
                          noDataText: "Không có thêm dữ liệu",
                          canLoadingText: "Kéo lên để tải thêm dữ liệu",
                          failedText: "Tải thêm dữ liệu bị lỗi",
                          idleText: "",
                          idleIcon: null,
                          outerBuilder: (b) => Container(
                            height: IZIDimensions.ONE_UNIT_SIZE * 90,
                            color: ColorResources.NEUTRALS_11,
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            color: ColorResources.NEUTRALS_11,
                            child: Column(
                              children: [
                                if (controller.bannerList.isEmpty)
                                  const SizedBox()
                                else
                                  IZISlider(
                                      onTap: (int index) {
                                        controller.bannerList[index].link!
                                                    .length ==
                                                24
                                            ? controller.onGotoPage(
                                                DetailPageRoutes.DETAIL_PAGE,
                                              )
                                            : IZIOther.openLink(
                                                url: controller
                                                    .bannerList[index].link!);
                                      },
                                      margin: EdgeInsets.zero,
                                      data: List<String>.generate(
                                          controller.bannerList.length,
                                          (index) => controller
                                              .bannerList[index].image!),
                                      secondaryChildStackSlider: (int index) =>
                                          const SizedBox()),

                                Container(
                                  margin: EdgeInsets.only(
                                      top: IZIDimensions.SPACE_SIZE_3X),
                                  padding: EdgeInsets.symmetric(
                                      vertical: IZIDimensions.SPACE_SIZE_2X,
                                      horizontal: IZIDimensions.SPACE_SIZE_4X),
                                  decoration: const BoxDecoration(
                                      color: ColorResources.WHITE),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: IZIDimensions
                                                        .SPACE_SIZE_2X),
                                                child: IZIText(
                                                  text: "Ví của tôi ",
                                                  style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: IZIDimensions
                                                              .FONT_SIZE_H6 *
                                                          1.05,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: ColorResources
                                                          .PRIMARY_8),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .showHideVisibility();
                                                },
                                                child: Icon(
                                                  controller.visibility
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  size: IZIDimensions
                                                          .ONE_UNIT_SIZE *
                                                      40,
                                                  color:
                                                      ColorResources.PRIMARY_8,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                IZIDimensions.ONE_UNIT_SIZE *
                                                    10,
                                          ),
                                          IZIText(
                                              text: controller.visibility
                                                  ? controller.defaultAccount
                                                  : controller.defaultAccount
                                                      .replaceAll(
                                                          RegExp('[0-9]'), "*"))
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AccountRoutes.ACCOUNT,
                                              arguments: 'account');
                                        },
                                        child: IZIText(
                                          text: " tài khoản >",
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6 *
                                                      1.05,
                                              fontWeight: FontWeight.w400,
                                              color: ColorResources.PRIMARY_9),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                // Flash Sale
                                Container(
                                  margin: EdgeInsets.only(
                                      top: IZIDimensions.SPACE_SIZE_3X),
                                  child: DisplayListViewOrGridViewPage(
                                    controller.flashSaleList,
                                    "Flash Sale",
                                    "Xem thêm >",
                                    itemWidget: (index) {
                                      return CommomItemViewPage(
                                        onTapDetail: () =>
                                            controller.onGotoPage(
                                                DetailPageRoutes.DETAIL_PAGE,
                                                obj: controller
                                                    .flashSaleList[index]
                                                    .productResponse),
                                        productResponse: controller
                                            .flashSaleList[index]
                                            .productResponse,
                                        image: controller.flashSaleList[index]
                                            .productResponse!.thumbnail,
                                        discountPercent:
                                            "${controller.flashSaleList[index].productResponse!.discountPercent!}",
                                        name: controller.flashSaleList[index]
                                            .productResponse!.name,
                                        price:
                                            "${IZIPrice.currencyConverterVND(controller.flashSaleList[index].productResponse!.price!)}đ",
                                        promotionalPrice:
                                            '${IZIPrice.currencyConverterVND(controller.flashSaleList[index].productResponse!.price! - (controller.flashSaleList[index].productResponse!.price! * (controller.flashSaleList[index].productResponse!.discountPercent! / 100)))}đ',
                                        ratingNumberAvg: double.parse(
                                            (controller
                                                        .flashSaleList[index]
                                                        .productResponse!
                                                        .totalPoint! /
                                                    controller
                                                        .flashSaleList[index]
                                                        .productResponse!
                                                        .countRate!)
                                                .toString()),
                                        star: star(
                                            controller.flashSaleList[index]
                                                .productResponse!.totalPoint!,
                                            controller.flashSaleList[index]
                                                .productResponse!.countRate!),
                                        countSold:
                                            "${controller.flashSaleList[index].productResponse!.countSold}",
                                      );
                                    },
                                    onTapRight: () {
                                      controller.onGotoPage(
                                          SearchResultsRoutes.SEARCH_RESULTS);
                                    },
                                    heightListView:
                                        IZIDimensions.ONE_UNIT_SIZE * 435,
                                    countdown: true,
                                    dateTimeEnd: controller
                                            .flashSaleList.isNotEmpty
                                        ? controller.flashSaleList.last.endTime
                                        : null,
                                    dateTime:
                                        controller.flashSaleList.isNotEmpty
                                            ? controller
                                                .flashSaleList.last.startTime
                                            : null,
                                    countdownWidget: controller
                                            .flashSaleList.isNotEmpty
                                        ? countdownWidget(
                                            EdgeInsets.all(
                                                IZIDimensions.SPACE_SIZE_1X),
                                            controller
                                                .flashSaleList.last.endTime,
                                            controller
                                                .flashSaleList.last.startTime)
                                        : const SizedBox(),
                                  ),
                                ),

                                //  Tìm kiếm hàng đầu
                                Container(
                                  margin: EdgeInsets.only(
                                      top: IZIDimensions.SPACE_SIZE_3X),
                                  child: DisplayListViewOrGridViewPage(
                                    controller.topSearchList,
                                    "Tìm kiếm hàng đầu",
                                    "Tìm hiểu ngay >",
                                    itemWidget: (index) =>
                                        topSearchWidget(controller, index),
                                    onTapRight: () {
                                      controller.onGotoPage(
                                          SearchResultsRoutes.SEARCH_RESULTS);
                                    },
                                    heightListView:
                                        IZIDimensions.ONE_UNIT_SIZE * 320,
                                  ),
                                ),

                                // Danh mục sản phẩm
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: IZIDimensions.SPACE_SIZE_3X),
                                  margin: EdgeInsets.only(
                                      top: IZIDimensions.SPACE_SIZE_5X * 1.5),
                                  decoration: const BoxDecoration(
                                    color: ColorResources.WHITE,
                                  ),
                                  child: DisplayListViewOrGridViewPage(
                                    controller.categoryResponseList,
                                    "Danh mục sản phẩm",
                                    "Xem tất cả >",
                                    itemWidget: (index) =>
                                        categoryWidget(controller, index),
                                    onTapRight: () {
                                      controller
                                          .onGotoPage(CategoryRoutes.CATEGORY);
                                    },
                                    heightListView:
                                        IZIDimensions.ONE_UNIT_SIZE * 170,
                                  ),
                                ),
                                // Thương hiệu sản phẩm
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: IZIDimensions.SPACE_SIZE_3X),
                                  margin: EdgeInsets.only(
                                      top: IZIDimensions.SPACE_SIZE_5X * 1.5),
                                  decoration: const BoxDecoration(
                                    color: ColorResources.WHITE,
                                  ),
                                  child: DisplayListViewOrGridViewPage(
                                      controller.brandResponseList,
                                      "Thương hiệu sản phẩm",
                                      "Xem tất cả >",
                                      itemWidget: (index) =>
                                          brandsWidget(controller, index),
                                      onTapRight: () {
                                        controller.onGotoPage(
                                            CategoryRoutes.CATEGORY);
                                      },
                                      heightListView:
                                          IZIDimensions.ONE_UNIT_SIZE * 150),
                                ),

                                // Sản phẩm mới nhất
                                Container(
                                  margin: EdgeInsets.only(
                                      top: IZIDimensions.SPACE_SIZE_3X),
                                  decoration: const BoxDecoration(),
                                  child: DisplayListViewOrGridViewPage(
                                    controller.lastestProductList,
                                    "Sản phẩm mới nhất",
                                    "Xem tất cả >",
                                    itemWidget: (index) {
                                      return CommomItemViewPage(
                                          onTapDetail: () {
                                            controller.onGotoPage(
                                                DetailPageRoutes.DETAIL_PAGE,
                                                obj: controller
                                                    .lastestProductList[index]);
                                          },
                                          productResponse: controller
                                              .lastestProductList[index],
                                          image: controller
                                              .lastestProductList[index]
                                              .thumbnail,
                                          discountPercent:
                                              "${controller.lastestProductList[index].discountPercent!}",
                                          name: controller
                                              .lastestProductList[index].name,
                                          price:
                                              "${IZIPrice.currencyConverterVND(controller.lastestProductList[index].price!)}đ",
                                          promotionalPrice:
                                              '${IZIPrice.currencyConverterVND(controller.lastestProductList[index].price! - (controller.lastestProductList[index].price! * (controller.lastestProductList[index].discountPercent! / 100)))}đ',
                                          ratingNumberAvg: controller.lastestProductList[index].countRate == 0
                                              ? 0
                                              : double.parse(
                                                  (controller.lastestProductList[index].totalPoint! /
                                                          controller
                                                              .lastestProductList[
                                                                  index]
                                                              .countRate!)
                                                      .toString()),
                                          star: star(
                                              controller
                                                  .lastestProductList[index]
                                                  .totalPoint!,
                                              controller
                                                  .lastestProductList[index]
                                                  .countRate!),
                                          countSold: "${controller.lastestProductList[index].countSold}",
                                          isGridView: true);
                                    },
                                    onTapRight: () {
                                      controller.onGotoPage(
                                          SearchResultsRoutes.SEARCH_RESULTS);
                                    },
                                    type: IZIListViewType.GRIDVIEW,
                                    mainAxisExtent:
                                        IZIDimensions.ONE_UNIT_SIZE * 435,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// appbar
  ///
  Widget appBar(BuildContext context) {
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
        Container(
          margin: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_3X),
          child: GestureDetector(
            onTap: () {
              IZIValidate.nullOrEmpty(controller.iduser)
                  ? Get.find<DashBoardController>().checkLogin()
                  : controller.onGotoPage(SearchResultsRoutes.SEARCH_RESULTS);
            },
            child: GestureDetector(
              onTap: () {
                IZIValidate.nullOrEmpty(controller.iduser)
                    ? Get.find<DashBoardController>().checkLogin()
                    : controller
                        .onGotoPage(SearchResultsRoutes.FAVORITE_PRODUCTS);
              },
              child: Icon(
                Icons.favorite_outline_outlined,
                color: const Color(0xff9098B1),
                size: IZIDimensions.ONE_UNIT_SIZE * 40,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_3X),
          child: GestureDetector(
            onTap: () {
              controller.onGotoPage(NotificationRoutes.NOTIFICATION);
            },
            child: Badge(
              showBadge: controller.listNotifi.isNotEmpty,
              position: BadgePosition.topEnd(),
              badgeContent: Text(
                "",
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  color: ColorResources.WHITE,
                ),
              ),
              child: const Icon(
                Icons.notifications_none,
                color: Color(0xff9098B1),
                size: 27,
              ),
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// Search
  ///
  Widget searchInput(BuildContext context) {
    return Obx(
      () {
        return IZIInput(
          isResfreshForm: IZIValidate.nullOrEmpty(controller.searchTerm),
          fillColor: ColorResources.NEUTRALS_11,
          type: IZIInputType.TEXT,
          placeHolder: 'Nhập tên sản phẩm',
          disbleError: true,
          prefixIcon: (val) {
            return Icon(
              Icons.search,
              color: const Color(0xffCCA46A),
              size: IZIDimensions.ONE_UNIT_SIZE * 40,
            );
          },
          onChanged: (val) {
            controller.searchTerm.value = val;
          },
          onSubmitted: (val) {
            if (!IZIValidate.nullOrEmpty(val)) {
              controller.onToSearch(val.toString());
            }
          },
        );
      },
    );
  }

  ///
  /// countdownWidget
  ///

  Row countdownWidget(
      EdgeInsets padding, DateTime? dateTimeFree, DateTime? dayStart) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_2X),
          padding: padding,
          decoration: BoxDecoration(
            color: ColorResources.RED_COLOR_2,
            borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
          ),
          child: IZIText(
            text: controller.showHour(dateTimeFree, day: dayStart),
            style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w400,
                color: ColorResources.WHITE),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_2X),
          padding: padding,
          decoration: BoxDecoration(
            color: ColorResources.RED_COLOR_2,
            borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
          ),
          child: IZIText(
            text: controller.showMinute(dateTimeFree, day: dayStart),
            style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w400,
                color: ColorResources.WHITE),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_2X),
          padding: padding,
          decoration: BoxDecoration(
            color: ColorResources.RED_COLOR_2,
            borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
          ),
          child: IZIText(
            text: controller.showSecond(dateTimeFree, day: dayStart),
            style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w400,
                color: ColorResources.WHITE),
          ),
        )
      ],
    );
  }

  ///
  /// phan tram rating
  ///

  String star(
    int totalPoint,
    int countRate,
  ) =>
      "${countRate == 0 ? "0" : double.parse((totalPoint / countRate).toString()).toStringAsFixed(1)} ($totalPoint)";

  ///
  /// Tìm kiếm hàng đầu
  ///
  GestureDetector topSearchWidget(HomeController controller, int id) {
    return GestureDetector(
      onTap: () {
        controller.onGotoPage(DetailPageRoutes.DETAIL_PAGE,
            obj: controller.topSearchList[id]);
      },
      child: Container(
        width: IZIDimensions.iziSize.width * .435,
        margin: EdgeInsets.only(
          right: IZIDimensions.SPACE_SIZE_4X,
        ),
        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: CommomImagePage(
                    url: controller.topSearchList[id].thumbnail)),
            Container(
              margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_2X),
              child: IZIText(
                text: controller.topSearchList[id].name ?? "",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.PRIMARY_8),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_2X),
              child: IZIText(
                text: parse(controller.topSearchList[id].content ?? "")
                    .documentElement!
                    .text,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    fontWeight: FontWeight.w400,
                    color: ColorResources.PRIMARY_8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///categoryWidget
  ///

  GestureDetector categoryWidget(HomeController controller, int id) {
    return GestureDetector(
      onTap: () {
        controller.onTapCategory(
            categoryResponse: controller.categoryResponseList[id]);
        // controller.onGotoPage(SearchResultsRoutes.SEARCH_RESULTS);
      },
      child: Container(
        width: IZIDimensions.ONE_UNIT_SIZE * 140,
        height: IZIDimensions.ONE_UNIT_SIZE * 140,
        margin: EdgeInsets.only(
            right: IZIDimensions.SPACE_SIZE_2X,
            top: IZIDimensions.SPACE_SIZE_2X),
        child: Column(
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(IZIDimensions.BORDER_RADIUS_7X * 1.5)),
                child: IZIImage(
                  controller.categoryResponseList[id].thumbnail!,
                  width: IZIDimensions.ONE_UNIT_SIZE * 85,
                  height: IZIDimensions.ONE_UNIT_SIZE * 85,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_3X),
              child: IZIText(
                text: controller.categoryResponseList[id].name ?? "",
                maxLine: 2,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    fontWeight: FontWeight.w400,
                    color: ColorResources.PRIMARY_8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// brandsWidget
  ///
  GestureDetector brandsWidget(HomeController controller, int id) {
    return GestureDetector(
      onTap: () {
        controller.onTapBrand(brand: controller.brandResponseList[id]);
      },
      child: Container(
        width: IZIDimensions.ONE_UNIT_SIZE * 120,
        padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_1X * 1.5),
        margin: EdgeInsets.only(
          right: IZIDimensions.SPACE_SIZE_3X,
        ),
        child: Column(
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(IZIDimensions.BORDER_RADIUS_7X * 1.2),
                child: IZIImage(
                  controller.brandResponseList[id].image!,
                  width: IZIDimensions.ONE_UNIT_SIZE * 90,
                  height: IZIDimensions.ONE_UNIT_SIZE * 90,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_4X),
              child: IZIText(
                text: controller.brandResponseList[id].name ?? "",
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: ColorResources.PRIMARY_7,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
