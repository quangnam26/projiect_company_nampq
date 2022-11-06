import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/searchresults/searchfilter/search_filter_controller.dart';

import '../../../../base_widget/izi_input.dart';

class SearchFilterPage extends GetView<SearchFilterController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      safeAreaBottom: false,
      // isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: 'Bộ lọc tìm kiếm ',
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.close,
            color: ColorResources.BLACK,
            size: 25,
          ),
        ),
      ),

      body: GetBuilder(
        init: SearchFilterController(),
        builder: (SearchFilterController controller) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: ColorResources.NEUTRALS_11,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: IZIDimensions.SPACE_SIZE_3X,
                        left: IZIDimensions.SPACE_SIZE_4X,
                        bottom: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      child: Text(
                        "Danh mục sản phẩm",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                            fontWeight: FontWeight.w600,
                            color: ColorResources.COLOR_BLACK_TEXT2),
                      ),
                    ),

                    // Danh mục sản phẩm
                    productPortfolio(controller),
                    Padding(
                      padding: EdgeInsets.only(
                        top: IZIDimensions.SPACE_SIZE_4X * 1.2,
                        left: IZIDimensions.SPACE_SIZE_4X,
                        bottom: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      child: Text(
                        "Thương hiệu sản phẩm",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                            fontWeight: FontWeight.w600,
                            color: ColorResources.COLOR_BLACK_TEXT2),
                      ),
                    ),
                    // thương hiệu sản phẩm
                    productsBrands(controller),
                    Padding(
                      padding: EdgeInsets.only(
                        top: IZIDimensions.SPACE_SIZE_4X * 1.2,
                        left: IZIDimensions.SPACE_SIZE_4X,
                        bottom: IZIDimensions.SPACE_SIZE_4X,
                      ),
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
                                  controller.price4(val);
                                  // controller.price1 = val;
                                  print("aaa ${controller.price1}");
                                },
                              ),
                            ),
                            SizedBox(
                              width: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            Expanded(
                              child: IZIInput(
                                onTap: () {},
                                onChanged: (val) {
                                  controller.price3(val);

                                  print("price2 = ${controller.price2}");
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
                    //silder
                    // slider(controller),

                    IZIButton(
                      margin: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_4X,
                          vertical: IZIDimensions.SPACE_SIZE_4X * 3),
                      onTap: () {
                        controller.onBack();
                        // Get.toNamed(SearchResultsRoutes.SEARCH_RESULTS);
                        print("object");
                      },
                      label: 'Áp dụng',
                      colorBG: ColorResources.ORANGE,
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
      // widgetBottomSheet: IZIButton(label: 'Áp dụng', onTap: () {}),
    );
  }

  ///
  /// thương hiệu sản phẩm
  ///
  Widget productsBrands(SearchFilterController controller) {
    return Column(
      children: [
        Wrap(
          spacing: IZIDimensions.SPACE_SIZE_4X,
          runSpacing: IZIDimensions.SPACE_SIZE_3X,
          children: [
            ...List.generate(
              controller.descTextPortfolio
                  ? 4
                  : controller.listBrandResponse.length,
              (index) => GestureDetector(
                onTap: () {
                  controller.selecColorBand(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: controller.selectBrands == index
                        ? ColorResources.YELLOW2
                        : ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BLUR_RADIUS_1X,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_4X,
                      vertical: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    child: Text(
                      controller.listBrandResponse[index].name.toString(),
                      style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          fontWeight: controller.selectBrands == index
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: controller.selectBrands == index
                              ? ColorResources.ORANGE
                              : ColorResources.NEUTRALS_5),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            controller.moreProductPortfolio();
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_2X,
                top: IZIDimensions.SPACE_SIZE_2X),
            child: controller.descTextPortfolio
                ? Text(
                    "Thu gọn",
                    style: TextStyle(
                        color: ColorResources.LABEL_ORDER_DA_GIAO,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                  )
                : Text(
                    "Hiển thị nhiều hơn",
                    style: TextStyle(
                        color: ColorResources.ORANGE,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                  ),
          ),
        )
      ],
    );
  }

  ///
  /// danh mục sản phẩm
  ///
  Widget productPortfolio(SearchFilterController controller) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: IZIDimensions.SPACE_SIZE_4X,
              right: IZIDimensions.SPACE_SIZE_4X),
          width: IZIDimensions.iziSize.width,
          child: controller.listCategoryResponse.isEmpty
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
              : Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  spacing: IZIDimensions.SPACE_SIZE_4X,
                  runSpacing: IZIDimensions.SPACE_SIZE_3X,
                  children: [
                    ...List.generate(
                      controller.descTextShowFlag
                          ? 4
                          : controller.listCategoryResponse.length,
                      (index) => GestureDetector(
                        onTap: () {
                          controller.selecColor(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.selected == index
                                ? ColorResources.YELLOW2
                                : ColorResources.WHITE,
                            borderRadius: BorderRadius.circular(
                              IZIDimensions.BLUR_RADIUS_1X,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.SPACE_SIZE_5X,
                              vertical: IZIDimensions.SPACE_SIZE_4X,
                            ),
                            child: Text(
                              controller.listCategoryResponse[index].name ?? "",
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                                fontWeight: controller.selected == index
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                color: controller.selected == index
                                    ? ColorResources.ORANGE
                                    : ColorResources.NEUTRALS_5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.moreProductBrands();
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_2X,
                top: IZIDimensions.SPACE_SIZE_2X),
            child: controller.descTextShowFlag
                ? const Text(
                    "Thu gọn ",
                    style: TextStyle(color: ColorResources.LABEL_ORDER_DA_GIAO),
                  )
                : const Text(
                    "",
                    style: TextStyle(color: ColorResources.LABEL_ORDER_DA_GIAO),
                  ),
          ),
        )
      ],
    );
  }

  ///
  /// customPriceRange
  ///
  Widget customPriceRange({required String title}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorResources.WHITE3),
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(IZIDimensions.SPACE_SIZE_1X),
        ),
        child: Padding(
          padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_4X),
          child: Text(
            title,
            style: TextStyle(
                color: ColorResources.NEUTRALS_8,
                fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  ///
  /// appbar
  ///
  Widget appBar(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.close,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_3X),
          child: Text(
            'Bộ lọc tìm kiếm',
            style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6 * 1.2,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
