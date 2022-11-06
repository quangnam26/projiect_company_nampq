import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_slider.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/components/food_top_card.dart';
import 'package:template/view/screen/components/nearby_card.dart';
import '../../../base_widget/izi_input.dart';
import '../../../helper/izi_validate.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      // background: const BackgroundHome(),
      body: GetBuilder(
        init: HomeController(),
        builder: (HomeController controller) {
          if (controller.isLoading) return spinKitWave;
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
                      margin: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      child: Column(
                        children: [
                          /// Appbar
                          appBar(),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_4X,
                          ),
                          Row(
                            children: [
                              // Search
                              Expanded(
                                child: searchInput(
                                  context,
                                ),
                              ),
                            ],
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
                          controller.onLoading(store: false);
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
                              /// Slider
                              Obx(() {
                                if (controller.banners.isEmpty) {
                                  return spinKitWave;
                                }
                                return IZISlider(
                                  data: controller.banners
                                      .map((e) => e.image.toString())
                                      .toList(),
                                );
                              }),

                              // categories
                              Container(
                                width: IZIDimensions.iziSize.width,
                                margin: EdgeInsets.symmetric(
                                  horizontal: IZIDimensions.SPACE_SIZE_4X,
                                ),
                                child: categories(),
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_2X,
                              ),

                              Container(
                                width: IZIDimensions.iziSize.width,
                                margin: EdgeInsets.symmetric(
                                  horizontal: IZIDimensions.SPACE_SIZE_4X,
                                ),
                                child: topStore(),
                              ),

                              Container(
                                width: IZIDimensions.iziSize.width,
                                margin: EdgeInsets.symmetric(
                                  horizontal: IZIDimensions.SPACE_SIZE_4X,
                                ),
                                child: nearBy(),
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
          );
        },
      ),
      widgetBottomSheet: GetBuilder(builder: (HomeController controller) {
        return GestureDetector(
          onTap: controller.isCheckOrder
              ? () {
                  controller.onToStatusOrder();
                }
              : () {},
          child: Container(
            height: 30,
            color: Colors.red,
            width: IZIDimensions.iziSize.width,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(
                  child: Marquee(
                    text: controller.isCheckOrder
                        ? 'Đơn hàng #${controller.orderResponse.codeOrder} đang thực hiện'
                        : 'Hiện chưa có đơn hàng nào',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: ColorResources.WHITE,
                    ),
                    blankSpace: 20.0,
                    velocity: 100.0,
                    startPadding: 10.0,
                    accelerationCurve: Curves.linear,
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorResources.WHITE,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  ///
  /// appbar
  ///
  Widget appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              controller.onToAddressPage();
            },
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: ColorResources.PRIMARY_3,
                ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_1X,
                ),
                Expanded(
                  child: Obx(() {
                    return Text(
                      controller.addressCurrrent.value,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.BLACK,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }),
                ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_1X,
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorResources.NEUTRALS_2,
                  size: IZIDimensions.ONE_UNIT_SIZE * 22,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: IZIDimensions.ONE_UNIT_SIZE * 60,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                controller.onGoToNotification();
              },
              child: Badge(
                position: BadgePosition.topEnd(),
                badgeContent: Text(
                  "",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    color: ColorResources.WHITE,
                  ),
                ),
                child: const Icon(
                  Icons.notifications_active,
                  color: ColorResources.NEUTRALS_4,
                ),
              ),
            ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_3X,
            ),
            GestureDetector(
              onTap: () {
                controller.goToAccount();
              },
              child: const Icon(
                Icons.menu,
                color: ColorResources.NEUTRALS_4,
              ),
            ),
          ],
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
          type: IZIInputType.TEXT,
          placeHolder: 'Tìm kiếm nhà hàng, món ăn',
          disbleError: true,
          prefixIcon: (val) {
            return GestureDetector(
              onTap: () {
                controller.onToSearch(controller.searchTerm.value);
              },
              child: const Icon(
                Icons.search,
              ),
            );
          },
          isResfreshForm: IZIValidate.nullOrEmpty(controller.searchTerm),
          fillColor: ColorResources.WHITE,
          borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
          onChanged: (val) {
            controller.searchTerm.value = val;
          },
          onSubmitted: (val) {
            controller.onToSearch(val.toString());
          },
        );
      },
    );
  }

  ///
  /// Categories
  ///
  Widget categories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Danh mục",
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: IZIDimensions.FONT_SIZE_H6,
            color: ColorResources.BLACK,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: IZIDimensions.SPACE_SIZE_1X * 0.8,
        ),
        Wrap(
          runSpacing: IZIDimensions.ONE_UNIT_SIZE * 15,
          spacing: IZIDimensions.ONE_UNIT_SIZE * 15,
          children: [
            ...List.generate(
              controller.categories.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    controller.onTapCategory(controller.categories[index]);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: IZIDimensions.ONE_UNIT_SIZE * 66,
                        height: IZIDimensions.ONE_UNIT_SIZE * 65,
                        decoration: BoxDecoration(
                          color: Color(
                              int.parse(controller.categories[index].color!,
                                  onError: (e) => 0xffF64A4C)).withOpacity(
                              0.1), //(controller.categories[index]['bg'] as Color).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.ONE_UNIT_SIZE * 15,
                          ),
                        ),
                        padding: EdgeInsets.all(
                          IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: SizedBox(
                          child: ClipRRect(
                            child: IZIImage(
                              controller.categories[index].thumbnail
                                  .toString(), //controller.categories[index]['icon'].toString(),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_1X * 0.8,
                      ),
                      SizedBox(
                        width: IZIDimensions.ONE_UNIT_SIZE * 120,
                        child: Text(
                          controller.categories[index].name
                              .toString(), //['title'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ],
    );
  }

  ///
  /// topStore
  ///
  Widget topStore() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: IZIDimensions.SPACE_SIZE_3X,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Đến với DPFood chỉ có mê",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    color: ColorResources.BLACK,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.onToSeeMore(2);
                  },
                  child: Text(
                    "Xem thêm >>",
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                      color: ColorResources.PRIMARY_1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Top các cửa hàng nổi bật nhất",
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                color: ColorResources.NEUTRALS_4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        SizedBox(
          height: IZIDimensions.SPACE_SIZE_4X,
        ),

        // List
        // Cưar hàng nỏi bật
        SizedBox(
          height: IZIDimensions.ONE_UNIT_SIZE * 220,
          child: SmartRefresher(
            controller: controller.refreshControllerTop,
            onLoading: () {
              controller.onLoading(
                store: true,
              );
            },
            onRefresh: () {
              controller.onRefresh();
            },
            enablePullUp: true,
            enablePullDown: false,
            header: const ClassicHeader(
              idleText: "Kéo xuống để làm mới dữ liệu",
              releaseText: "",
              completeText: "Làm mới dữ liệu thành công",
              refreshingText: "Đang làm mới dữ liệu",
              failedText: "Làm mới dữ liệu bị lỗi",
              canTwoLevelText: "Thả ra để làm mới dữ liệu",
            ),
            footer: const ClassicFooter(
              loadingText: "",
              noDataText: "Không có thêm dữ liệu",
              canLoadingText: "Kéo lên để tải thêm dữ liệu",
              failedText: "Tải thêm dữ liệu bị lỗi",
              idleText: "",
              idleIcon: null,
            ),
            scrollDirection: Axis.horizontal,
            child: Obx(
              () {
                return ListView.builder(
                  itemCount: controller.storeHot.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.onTapToStore(
                          store: controller.storeHot[index],
                        );
                      },
                      child: FoodTopCard(
                        image: controller.storeHot[index].banner ?? '',
                        comments: IZIValidate.nullOrEmpty(
                                controller.storeHot[index].statitisReviews)
                            ? 0
                            : controller.storeHot[index].statitisReviews!
                                    .countRating ??
                                0,
                        rate: IZINumber.parseDouble(IZIValidate.nullOrEmpty(
                                controller.storeHot[index].rankPoint)
                            ? 0
                            : controller.storeHot[index].rankPoint ?? 0),
                        title: controller.storeHot[index].fullName ?? '',
                      ),
                    );
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }

  ///
  /// nearby
  ///
  Widget nearBy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: IZIDimensions.SPACE_SIZE_3X,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quanh đây có gì ngon?",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    color: ColorResources.BLACK,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.onToSeeMore(1);
                  },
                  child: Text(
                    "Xem thêm >>",
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                      color: ColorResources.PRIMARY_1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(
          height: IZIDimensions.SPACE_SIZE_4X,
        ),

        // List
        SizedBox(
          child: Obx(
            () {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.productsNearBy.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.onTapToStore(
                        store: controller.productsNearBy[index].idUser!,
                      );
                    },
                    child: NearByCard(
                      image: controller.productsNearBy[index].thumbnail ?? '',
                      comments: IZIValidate.nullOrEmpty(controller
                              .productsNearBy[index].idUser!.statitisReviews)
                          ? 0
                          : controller.productsNearBy[index].idUser!
                                  .statitisReviews!.countRating ??
                              0,
                      rate: IZINumber.parseDouble(IZIValidate.nullOrEmpty(
                              controller.productsNearBy[index].idUser)
                          ? 0
                          : controller.productsNearBy[index].idUser!.rankPoint),
                      description:
                          controller.productsNearBy[index].idUser!.address ??
                              '',
                      title: controller.productsNearBy[index].name.toString(),
                      km: IZIValidate.nullOrEmpty(
                              controller.productsNearBy[index].distanceMatrix)
                          ? ''
                          : controller.productsNearBy[index].distanceMatrix!
                                  .distance ??
                              '',
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
