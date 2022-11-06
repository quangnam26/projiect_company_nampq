import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_tabbar.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/components/comom_item_view_page.dart';
import 'package:template/view/screen/components/display_listView_or_gridView.dart';
import 'package:template/view/screen/searchresults/search_results_controller.dart';
import '../../../base_widget/izi_button.dart';
import '../../../base_widget/izi_input.dart';
import '../../../base_widget/izi_text.dart';
import '../../../helper/izi_number.dart';
import '../../../helper/izi_price.dart';

class SearchResultsPage extends GetView<SearchResultsController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      key1: _scaffoldKey,
      drawer: GetBuilder(
        init: SearchResultsController(),
        builder: (SearchResultsController controller) {
          if (controller.ickeckLoading) {
            return SizedBox(
              height: IZIDimensions.iziSize.height * 0.8,
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.ORANGE,
                ),
              ),
            );
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Drawer(
              child: SingleChildScrollView(
                child: SizedBox(
                  // height: IZIDimensions.iziSize.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: IZIDimensions.SPACE_SIZE_2X,
                            bottom: IZIDimensions.SPACE_SIZE_2X),
                        child: IZIText(
                          text: "Bộ lọc tìm kiếm",
                          style: TextStyle(
                              // color: ColorResources.BLACK,
                              fontSize: IZIDimensions.FONT_SIZE_H5 * 0.9,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        color: ColorResources.NEUTRALS_7,
                        height: IZIDimensions.iziSize.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: IZIDimensions.SPACE_SIZE_2X,
                                left: IZIDimensions.SPACE_SIZE_2X,
                                bottom: IZIDimensions.SPACE_SIZE_4X,
                              ),

                              // Danh mục sản phẩm .
                              child: nameProductPortfolio(),
                            ),

                            /// List danh mục sản phẩm.
                            gridviewProductPortfolio(controller),

                            /// Thương hiệu sản phẩm .
                            nameProductBrands(),

                            /// list thương hiệu sản phẩm .
                            gridviewProductBrands(controller),

                            Padding(
                              padding: EdgeInsets.only(
                                  left: IZIDimensions.SPACE_SIZE_2X,
                                  bottom: IZIDimensions.SPACE_SIZE_3X),
                              child: Text(
                                "Khoảng giá",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: IZIDimensions.SPACE_SIZE_4X,
                                ),
                                //Khoảng giá
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: IZIInput(
                                        suficIcons: "",
                                        // hintStyle: TextStyle(color: Colors.green),
                                        type: IZIInputType.PRICE,
                                        borderRadius: 10,
                                        // suffixIcon: null,
                                        fillColor: ColorResources.WHITE,
                                        onChanged: (val) {
                                          controller.priceTwo(val);

                                          print("aaa ${controller.price1}");
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: IZIDimensions.SPACE_SIZE_2X,
                                    ),
                                    Expanded(
                                      child: IZIInput(
                                        onChanged: (val) {
                                          controller.priceOne(val);
                                          print("val ${val}");
                                        },
                                        suficIcons: "",
                                        type: IZIInputType.PRICE,
                                        borderRadius: 10,
                                        fillColor: ColorResources.WHITE,
                                      ),
                                    )
                                  ],
                                )
                                // priceRange(),
                                ),

                            Row(
                              children: [
                                Expanded(
                                  child: IZIButton(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: IZIDimensions.SPACE_SIZE_4X,
                                        vertical:
                                            IZIDimensions.SPACE_SIZE_4X * 3),
                                    onTap: () {
                                      controller.establish();

                                      print("object");
                                    },
                                    label: 'Thiết lập',
                                    colorBG: ColorResources.NEUTRALS_5,
                                  ),
                                ),
                                Expanded(
                                  child: IZIButton(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: IZIDimensions.SPACE_SIZE_4X,
                                        vertical:
                                            IZIDimensions.SPACE_SIZE_4X * 3),
                                    onTap: () {
                                      controller.backToScreen();

                                      print("object");
                                    },
                                    label: 'Áp dụng',
                                    colorBG: ColorResources.ORANGE,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      // isSingleChildScrollView: false,
      safeAreaTop: false,
      safeAreaBottom: false,
      // background: BackgroundAppBar(),
      body: GetBuilder(
        init: SearchResultsController(),
        builder: (SearchResultsController controller) {
          if (controller.isLoading) {
            return Padding(
              padding: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_4X * 4),
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.ORANGE,
                ),
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: ColorResources.WHITE2,
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: IZIDimensions.SPACE_SIZE_4X * 3,
                            left: IZIDimensions.SPACE_SIZE_3X,
                            right: IZIDimensions.SPACE_SIZE_3X,
                            bottom: IZIDimensions.SPACE_SIZE_4X),
                        child: appBar(context)),
                  ],
                ),
              ),
              IZITabBar<Map>(
                colorUnderLine: ColorResources.ORANGE,
                colorText: ColorResources.ORANGE,
                currentIndex: controller.currentIndexTabbar,
                items: controller.tabbarStringList,
                onTapChangedTabbar: (index) {
                  controller.selectIndexTabber(index);
                },
                isSort: controller.isSort,
              ),
              if (controller.isload)
                const Center(
                  child: CircularProgressIndicator(
                    color: ColorResources.ORANGE,
                  ),
                )
              else
                Expanded(
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: IZIDimensions.SPACE_SIZE_2X,
                              left: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: IZIText(
                              text:
                                  "${controller.listProducts.length} kết quả được tìm thấy",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  color: ColorResources.NEUTRALS_8,
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                            ),
                          ),
                          Container(
                            color: ColorResources.NEUTRALS_11,
                            child: SingleChildScrollView(
                                child: DisplayListViewOrGridViewPage(
                              controller.listProducts,
                              "",
                              "",
                              itemWidget: (index) {
                                return CommomItemViewPage(
                                    onTapDetail: () {
                                      controller.onTapProduct(
                                        proudct: controller.listProducts[index],
                                      );
                                    },
                                    productResponse:
                                        controller.listProducts[index],
                                    image: controller
                                        .listProducts[index].thumbnail,
                                    discountPercent:
                                        "${controller.listProducts[index].discountPercent!}",
                                    name: controller.listProducts[index].name,
                                    price:
                                        "${IZIPrice.currencyConverterVND(controller.listProducts[index].price!)}đ",
                                    promotionalPrice:
                                        '${IZIPrice.currencyConverterVND(controller.listProducts[index].price! - (controller.listProducts[index].price! * (controller.listProducts[index].discountPercent! / 100)))}đ',
                                    star: star(
                                        controller
                                            .listProducts[index].totalPoint!,
                                        controller
                                            .listProducts[index].countRate!),
                                    countSold:
                                        "${controller.listProducts[index].countSold}",
                                    ratingNumberAvg: double.parse((controller
                                                .listProducts[index]
                                                .totalPoint! /
                                            controller
                                                .listProducts[index].countRate!)
                                        .toString()),
                                    isGridView: true);
                              },
                              onTapRight: () {},
                              type: IZIListViewType.GRIDVIEW,
                              mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 435,
                            )),
                          ),
                        ],
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
  /// gridview Product Brands.
  ///

  Widget gridviewProductBrands(SearchResultsController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_2X),
      child: Column(
        children: [
          IZIListView(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 50,
            type: IZIListViewType.GRIDVIEW,
            crossAxisCount: 2,
            itemCount: controller.descTextShowFlag
                ? 4
                : controller.listBrandResponse.length,
            builder: (index) {
              return GestureDetector(
                onTap: () {
                  controller.selecColorBrand(index);
                },
                child: Container(
                  color: controller.selectBrands == index &&
                          controller.idBrand.isNotEmpty
                      ? ColorResources.YELLOW2
                      : ColorResources.WHITE,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: IZIText(
                        text: controller.listBrandResponse[index].name ?? "",
                        style: TextStyle(
                            color: ColorResources.NEUTRALS_2,
                            fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              controller.moreProductBrands();
            },
            child: Container(
              margin: EdgeInsets.only(
                  bottom: IZIDimensions.SPACE_SIZE_2X,
                  top: IZIDimensions.SPACE_SIZE_2X),
              child: controller.descTextShowFlag
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Thu gọn ",
                          style: TextStyle(
                              color: ColorResources.LABEL_ORDER_DA_GIAO),
                        ),
                        Icon(
                          Icons.keyboard_arrow_up_outlined,
                          color: ColorResources.GREY,
                          size: 30,
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Hiển thị nhiều hơn ",
                          style: TextStyle(
                              color: ColorResources.LABEL_ORDER_DA_GIAO),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: ColorResources.GREY,
                          size: 30,
                        )
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// name Product Brands.
  ///

  Widget nameProductBrands() {
    return Padding(
      padding: EdgeInsets.only(
          left: IZIDimensions.SPACE_SIZE_2X,
          bottom: IZIDimensions.SPACE_SIZE_3X),
      child: Text(
        "Thương hiệu sản phẩm",
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: IZIDimensions.FONT_SIZE_H6,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  ///
  /// gridview Product Portfolio.
  ///
  Widget gridviewProductPortfolio(SearchResultsController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_2X),
      child: Column(
        children: [
          IZIListView(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 50,
            type: IZIListViewType.GRIDVIEW,
            crossAxisCount: 2,
            itemCount: controller.descTextPortfolio
                ? 4
                : controller.listCategoryResponse.length,
            builder: (index) {
              return GestureDetector(
                onTap: () {
                  controller.selecColorProducts(index);
                },
                child: Container(
                  color: controller.selected == index &&
                          controller.idCategory.isNotEmpty
                      ? ColorResources.YELLOW2
                      : ColorResources.WHITE,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: IZIText(
                        text: controller.listCategoryResponse[index].name ?? "",
                        style: TextStyle(
                            color: ColorResources.NEUTRALS_2,
                            fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              controller.moreProductPortfolio();
            },
            child: Container(
              margin: EdgeInsets.only(
                  bottom: IZIDimensions.SPACE_SIZE_2X,
                  top: IZIDimensions.SPACE_SIZE_2X),
              child: controller.descTextPortfolio
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Thu gọn ",
                          style: TextStyle(
                              color: ColorResources.LABEL_ORDER_DA_GIAO),
                        ),
                        Icon(
                          Icons.keyboard_arrow_up_outlined,
                          color: ColorResources.GREY,
                          size: 30,
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Hiển thị nhiều hơn ",
                          style: TextStyle(
                              color: ColorResources.LABEL_ORDER_DA_GIAO),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: ColorResources.GREY,
                          size: 30,
                        )
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// name Product Portfolio.
  ///
  Text nameProductPortfolio() {
    return Text(
      "Danh mục sản phẩm",
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: IZIDimensions.FONT_SIZE_H6,
        fontWeight: FontWeight.w600,
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
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.NEUTRALS_3,
          ),
        ),
        Expanded(
          child: Container(
            child: searchInput(
              context,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: IZIDimensions.SPACE_SIZE_2X,
          ),
          child: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
              // controller.goToFilterPage();
              // controller.gotofilter();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 5, bottom: 5),
              child: Icon(
                Icons.filter_alt_outlined,
                size: 35,
                color: ColorResources.ORANGE,
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
    // return IZISearch(term: "");
    return IZIInput(
      miniSize: true,
      controller: TextEditingController(
          text: IZIValidate.nullOrEmpty(controller.searchController)
              ? ''
              : controller.searchController),
      type: IZIInputType.TEXT,
      placeHolder: IZIValidate.nullOrEmpty(controller.searchController)
          ? 'Nhập tên sản phẩm'
          : controller.searchController,
      disbleError: true,
      prefixIcon: (val) {
        return GestureDetector(
          onTap: () {
            // controller.inputSearch();
          },
          child: const Icon(
            Icons.search,
            color: Color(0xffCCA46A),
            size: 25,
          ),
        );
      },
      fillColor: ColorResources.NEUTRALS_6,
      onChanged: (val) {
        controller.searchController = val;
      },
      onSubmitted: (val) {
        controller.onConfirmSearch();
      },
    );
  }

  String star(
    int totalPoint,
    int countRate,
  ) =>
      "${countRate == 0 ? "0" : double.parse((totalPoint / countRate).toString()).toStringAsFixed(1)} ($totalPoint)";
}
