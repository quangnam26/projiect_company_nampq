import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_search.dart';
import 'package:template/data/model/category/category_response.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_text_style.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/components/nearby_card.dart';
import 'package:template/view/screen/search/search_controller.dart';
import '../../../base_widget/izi_input.dart';
import 'components/grid_view_filter.dart';

class SearchPage extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      // background: const BackgroundSearch(),
      safeAreaBottom: false,
      body: GetBuilder(
        builder: (SearchController controller) {
          return Stack(
            children: [
              GestureDetector(
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
                        SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 50,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.SPACE_SIZE_4X,
                          ),
                          child: sortWidget(),
                        ),
                        Expanded(
                          child: SmartRefresher(
                            controller: controller.refreshController,
                            onLoading: () {
                              controller.onLoading();
                            },
                            onRefresh: () {
                              controller.onRefresh();
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
                                children: [
                                  Container(
                                    width: IZIDimensions.iziSize.width,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: IZIDimensions.SPACE_SIZE_4X,
                                    ),
                                    child: dataSearch(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Builder(builder: (context) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  child: Obx(() {
                    return IZISearch(
                      onTap: (val) {
                        controller.term.value = val;
                        controller.onSearch();
                      },
                      onChange: (val) {
                        controller.term.value = val;
                        controller.onSearch();
                      },
                      term: controller.term.value,
                      onShowDrawer: () {
                        controller.onShowDrawer(context);
                      },
                    );
                  }),
                );
              }),
            ],
          );
        },
      ),
      drawer: Drawer(
        child: Container(
          color: ColorResources.NEUTRALS_7,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        Scaffold.of(context).closeEndDrawer();
                      },
                      child: const Icon(
                        Icons.cancel,
                        color: ColorResources.NEUTRALS_5,
                      ),
                    );
                  }),
                  Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        controller.clearFilter(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          right: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: const Text(
                          "Xóa",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: ColorResources.RED,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: IZIDimensions.SPACE_SIZE_2X,
                ),
                child: Text(
                  "Bộ lọc",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: ColorResources.NEUTRALS_2,
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        return GridViewFilter(
                          value: controller.province.value,
                          data: controller.provinces,
                          icon: ImagesPath.map,
                          onTap: (ProvinceResponse val) {
                            controller.onChangeArea(val);
                          },
                        );
                      }),
                      Obx(() {
                        return GridViewFilter(
                          value: controller.category.value,
                          data: controller.categories,
                          icon: ImagesPath.category,
                          label: 'Danh mục',
                          onTap: (CategoryResponse val) {
                            controller.onChangeCategory(val);
                          },
                        );
                      }),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: const TitleTile(
                              icon: ImagesPath.price,
                              label: 'Giá',
                            ),
                          ),
                          //
                          filterPrice(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.SPACE_SIZE_2X,
                ),
                child: Builder(builder: (context) {
                  return IZIButton(
                    padding: EdgeInsets.all(
                      IZIDimensions.SPACE_SIZE_3X,
                    ),
                    borderRadius: 5,
                    onTap: () {
                      Scaffold.of(context).closeEndDrawer();
                      controller.onRefresh();
                    },
                    label: "Áp dụng",
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// Lọc theo gía
  ///
  Widget filterPrice() {
    return Obx(
      () {
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: IZIDimensions.SPACE_SIZE_2X,
            horizontal: IZIDimensions.SPACE_SIZE_2X,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: ColorResources.NEUTRALS_6.withOpacity(0.5),
                padding: EdgeInsets.all(
                  IZIDimensions.SPACE_SIZE_2X,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: IZIInput(
                        type: controller.min <= 0 ? IZIInputType.PHONE : IZIInputType.NUMBER,
                        borderRadius: 5,
                        disbleError: true,
                        miniSize: true,
                        controller: controller.minController,
                        // initValue: controller.min.value.toString(),
                        placeHolder: 'TỐI THIỂU',
                        onChanged: (val) {
                          controller.min.value = IZINumber.parseDouble(val.replaceAll('.', ''));
                        },
                      ),
                    ),
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    Container(
                      height: 1,
                      width: 10,
                      color: ColorResources.RED,
                    ),
                    SizedBox(
                      width: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    Expanded(
                      child: IZIInput(
                        type: controller.max <= 0 ? IZIInputType.PHONE : IZIInputType.NUMBER,
                        borderRadius: 5,
                        disbleError: true,
                        miniSize: true,
                        // initValue: controller.max.value.toString(),
                        placeHolder: 'TỐI ĐA',
                        controller: controller.maxController,
                        onChanged: (val) {
                          controller.max.value = IZINumber.parseDouble(val.replaceAll('.', ''));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 65,
                  mainAxisSpacing: 1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                ),
                shrinkWrap: true,
                itemCount: controller.prices.length,
                itemBuilder: (context, index) {
                  final val = controller.prices[index];
                  return GestureDetector(
                    onTap: () {
                      controller.onChangePrice(val['min']!, val['max']!);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: IZIDimensions.SPACE_SIZE_1X,
                        bottom: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      padding: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_1X,
                      ),
                      decoration: BoxDecoration(
                        color: val['max']! * 1000 == controller.max.value ? ColorResources.PRIMARY_1 : ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(
                          IZIDimensions.ONE_UNIT_SIZE * 10,
                        ),
                      ),
                      child: Text(
                        '${val['min']!.toStringAsFixed(0)} - ${val['max']!.toStringAsFixed(0)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          color: val['max']! * 1000 == controller.max.value ? ColorResources.WHITE : ColorResources.BLACK,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ///
  /// sort
  ///
  Widget sortWidget() {
    return Row(
      children: [
        PopupMenuButton(
          child: Chip(
            label: Obx(
              () {
                return Row(
                  children: [
                    if (controller.sort.value == 0) const Text("Sắp xếp") else Text(controller.sorts[controller.sort.value].toString()),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                );
              },
            ),
          ),
          itemBuilder: (context) {
            return controller.sorts.entries.map((e) {
              return PopupMenuItem(
                child: Text(e.value),
                onTap: () {
                  controller.onChangeSort(e.key);
                },
              );
            }).toList();
          },
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_2X,
        ),
        if (!IZIValidate.nullOrEmpty(controller.province.value.id))
          ActionChip(
            label: Text(controller.province.value.name.toString()),
            onPressed: () {},
          ),
        if (!IZIValidate.nullOrEmpty(controller.province.value.id))
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_2X,
          ),
        if (!IZIValidate.nullOrEmpty(controller.category.value.id))
          ActionChip(
            label: Text(controller.category.value.name.toString()),
            onPressed: () {},
          ),
        if (!IZIValidate.nullOrEmpty(controller.category.value.id))
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_2X,
          ),
        if (controller.min.value >= 0 && controller.max.value > 0)
          ActionChip(
            label: Text('${IZIPrice.currencyConverterVND(controller.min.value)} - ${IZIPrice.currencyConverterVND(controller.max.value)}'),
            onPressed: () {},
          ),
      ],
    );
  }

  ///
  /// List product
  ///
  Widget dataSearch() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: controller.buildObx(
        (data) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data!.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.onTapToStore(
                    data[index].idUser!,
                  );
                },
                child: NearByCard(
                  image: data[index].thumbnail ?? '',
                  comments: IZIValidate.nullOrEmpty(data[index].idUser!.statitisReviews) ? 0 : data[index].idUser!.statitisReviews!.countRating ?? 0,
                  rate: IZINumber.parseDouble(IZIValidate.nullOrEmpty(data[index].idUser) ? 0 : data[index].idUser!.rankPoint ?? 0),
                  description: data[index].description ?? '',
                  title: data[index].name ?? '',
                  km: IZIValidate.nullOrEmpty(data[index].distanceMatrix) ? '' : data[index].distanceMatrix!.distance ?? '',
                ),
              );
            },
          );
        },
        onEmpty: SizedBox(
          height: IZIDimensions.iziSize.height * 0.7,
          child: Center(
            child: Text(
              "Không có dữ liệu",
              style: textStyleH6,
            ),
          ),
        ),
        onLoading: SizedBox(
          height: IZIDimensions.iziSize.height * 0.8,
          child: Center(
            child: spinKitWave,
          ),
        ),
      ),
    );
  }
}
