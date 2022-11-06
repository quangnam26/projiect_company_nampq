import 'dart:io';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/store/store_controller.dart';
import '../../../base_widget/izi_image.dart';
import '../../../utils/images_path.dart';
import 'components/product_card.dart';

class StorePage extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      // background: const BackgroundAppBar(),
      safeAreaBottom: false,
      safeAreaTop: false,
      body: SmartRefresher(
        controller: controller.refreshController,
        scrollController: controller.scrollController,
        physics: const ClampingScrollPhysics(),
        onLoading: () {
          controller.onLoading();
        },
        onRefresh: () {
          controller.onRefresh();
        },
        enablePullUp: true,
        enablePullDown: false,
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
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      FadeTransition(
                        opacity: controller.hideFabAnimController!,
                        child: SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 300,
                          child: IZIImage(IZIValidate.nullOrEmpty(controller.store) ? '' : controller.store!.banner ?? ''),
                        ),
                      ),
                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 150,
                      ),
                      Container(
                        color: ColorResources.NEUTRALS_7,
                        width: IZIDimensions.iziSize.width,
                        // padding: EdgeInsets.all(
                        //   IZIDimensions.SPACE_SIZE_4X,
                        // ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                IZIDimensions.SPACE_SIZE_4X,
                              ),
                              child: Text(
                                controller.store!.isGetOpen == true ? "Đang mở cửa" : 'Đóng cửa',
                                style: TextStyle(
                                  color: ColorResources.PRIMARY_6,
                                  fontWeight: FontWeight.w500,
                                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                ),
                              ),
                            ),
                            // Thông tin đánh gía
                            rateInfo(
                              controller: controller,
                            ),
                            // Danh sách sản phẩm
                            productList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 120,
                    child: storeCard(),
                  ),
                  // Back
                  Positioned(
                    left: IZIDimensions.SPACE_SIZE_4X,
                    top: MediaQuery.of(context).viewPadding.top,
                    child: GestureDetector(
                      onTap: () {
                        controller.onBack();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: ColorResources.WHITE,
                      ),
                    ),
                  ),
                  // Search
                  Positioned(
                    right: IZIDimensions.SPACE_SIZE_4X,
                    top: MediaQuery.of(context).viewPadding.top,
                    child: GestureDetector(
                      onTap: () {
                        controller.onBack();
                      },
                      child: const Icon(
                        Icons.search,
                        color: ColorResources.WHITE,
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: MediaQuery.of(context).viewPadding.bottom),
              if (Platform.isIOS)
                SizedBox(
                  height: IZIDimensions.ONE_UNIT_SIZE * 10,
                )
              else
                SizedBox(
                  height: IZIDimensions.ONE_UNIT_SIZE * 80,
                )
            ],
          ),
        ),
      ),
      widgetBottomSheet: BottomAppBar(
        color: ColorResources.WHITE,
        elevation: 0,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_4X,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.showModelBottomCart(context);
                },
                child: Container(
                  padding: EdgeInsets.all(
                    IZIDimensions.SPACE_SIZE_2X,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorResources.PRIMARY_1,
                    ),
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BLUR_RADIUS_2X,
                    ),
                  ),
                  child: Obx(() {
                    return Badge(
                      position: BadgePosition.topEnd(),
                      badgeContent: Text(
                        controller.orderProductList.length.toString(),
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          color: ColorResources.WHITE,
                        ),
                      ),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: ColorResources.PRIMARY_1,
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: IZIButton(
                    onTap: () {
                      controller.showModelBottomCart(context);
                    },
                    label: "Thanh toán",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// Thông tin cửa hàng
  ///
  Widget storeCard() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
      ),
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_1X,
        horizontal: IZIDimensions.SPACE_SIZE_1X,
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        boxShadow: IZIOther().boxShadow,
        borderRadius: BorderRadius.circular(
          IZIDimensions.ONE_UNIT_SIZE * 20,
        ),
      ),
      height: IZIDimensions.ONE_UNIT_SIZE * 240,
      width: IZIDimensions.iziSize.width * 0.8,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: IZIImage(ImagesPath.promo),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              Text(
                "Đối tác của D&P Food",
                style: TextStyle(
                  color: ColorResources.PRIMARY_1,
                  fontWeight: FontWeight.w500,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                ),
              ),
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          // Title
          Text(
            IZIValidate.nullOrEmpty(controller.store) ? '' : controller.store!.fullName ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorResources.PRIMARY_1,
              fontWeight: FontWeight.w500,
              fontSize: IZIDimensions.FONT_SIZE_H4,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          // About
          Obx(
            () {
              return RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: IZIValidate.nullOrEmpty(controller.store)
                      ? ''
                      : IZIValidate.nullOrEmpty(controller.distance)
                          ? ''
                          : '(${controller.distance.value})  ',
                  style: TextStyle(
                    color: ColorResources.NEUTRALS_1,
                    fontWeight: FontWeight.w500,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  ),
                  children: [
                    TextSpan(
                      text: IZIValidate.nullOrEmpty(controller.store) ? '' : controller.store!.address ?? '*Số 12 Châu Thị Vĩnh Tế- quận Ngũ Hành Sơn- Đà Nẵng',
                      style: TextStyle(
                        color: ColorResources.NEUTRALS_4,
                        fontWeight: FontWeight.w500,
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget rateInfo({required StoreController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          thickness: 0.2,
          color: ColorResources.PRIMARY_1,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_2X,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  rate(
                    icon: Icons.star,
                    title: '${IZIValidate.nullOrEmpty(controller.store) ? '' : controller.store!.rankPoint ?? ''} (${IZIValidate.nullOrEmpty(controller.store) ? '' : IZIValidate.nullOrEmpty(controller.store!.statitisReviews) ? 0 : controller.store!.statitisReviews!.countRating}+)',
                    iconColor: ColorResources.PRIMARY_3,
                  ),
                  Obx(() {
                    return rate(
                      icon: Icons.shopping_bag_rounded,
                      title: '${IZIValidate.nullOrEmpty(controller.store) ? '0' : controller.totalSaled.value} sản phẩm đã bán',
                      iconColor: ColorResources.NEUTRALS_3,
                    );
                  }),
                  GestureDetector(
                    onTap: () {
                      controller.onGoToRatingStore();
                    },
                    child: const Text(
                      "Xem đánh giá",
                      style: TextStyle(
                        color: ColorResources.PRIMARY_1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_2X,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  boxRate(
                    icon: Icons.sentiment_very_satisfied_rounded,
                    value: IZIValidate.nullOrEmpty(controller.store!.statitisReviews) ? '' : '(${(controller.store!.statitisReviews!.shopReactions!.delicious ?? 0) > 10 ? '${controller.store!.statitisReviews!.shopReactions!.delicious}+' : '${controller.store!.statitisReviews!.shopReactions!.delicious ?? 0}'})',
                    title: 'Ngon xỉu',
                    iconColor: ColorResources.RED.withOpacity(0.5),
                  ),
                  boxRate(
                    icon: Icons.thumb_up,
                    value: IZIValidate.nullOrEmpty(controller.store!.statitisReviews) ? '' : '(${(controller.store!.statitisReviews!.shopReactions!.satisfied ?? 0) > 10 ? '${controller.store!.statitisReviews!.shopReactions!.satisfied}+' : '${controller.store!.statitisReviews!.shopReactions!.satisfied ?? 0}'})',
                    title: 'Hài lòng',
                    iconColor: ColorResources.RED.withOpacity(0.5),
                  ),
                  boxRate(
                    icon: CupertinoIcons.cube_box_fill,
                    value: IZIValidate.nullOrEmpty(controller.store!.statitisReviews) ? '' : '(${(controller.store!.statitisReviews!.shopReactions!.wellPacked ?? 0) > 10 ? '${controller.store!.statitisReviews!.shopReactions!.wellPacked}+' : '${controller.store!.statitisReviews!.shopReactions!.wellPacked ?? 0}'})',
                    title: 'Đóng gói kỹ',
                    iconColor: ColorResources.RED.withOpacity(0.5),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 0.2,
          color: ColorResources.PRIMARY_1,
        )
      ],
    );
  }

  ///
  ///  icon rate
  ///
  Widget rate({
    required String title,
    required IconData icon,
    Color? iconColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor ?? ColorResources.PRIMARY_1,
        ),
        SizedBox(
          width: IZIDimensions.ONE_UNIT_SIZE * 4,
        ),
        Text(
          title,
          style: TextStyle(
            color: ColorResources.NEUTRALS_3,
            fontWeight: FontWeight.w500,
            fontSize: IZIDimensions.FONT_SIZE_SPAN,
          ),
        )
      ],
    );
  }

  ///
  /// ĐÁNH GIÁ ĐỘ HÀI LÒNG
  ///
  Widget boxRate({
    required String title,
    required String value,
    required IconData icon,
    Color? iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          IZIDimensions.ONE_UNIT_SIZE * 50,
        ),
        color: ColorResources.PRIMARY_1.withOpacity(0.05),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_1X,
        vertical: IZIDimensions.ONE_UNIT_SIZE * 4,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor ?? ColorResources.PRIMARY_1,
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_1X,
          ),
          Text(
            title,
            style: TextStyle(
              color: ColorResources.NEUTRALS_3,
              fontWeight: FontWeight.w500,
              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.6,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: ColorResources.NEUTRALS_4,
              fontWeight: FontWeight.w500,
              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.6,
            ),
          )
        ],
      ),
    );
  }

  /// danh sách sản phẩm
  Widget productList() {
    return controller.buildObx((state) {
      return Container(
        padding: EdgeInsets.all(
          IZIDimensions.SPACE_SIZE_4X,
        ),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.productsMap.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.productsMap.keys.toList()[index].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: IZIDimensions.FONT_SIZE_H5,
                  ),
                ),
                SizedBox(
                  height: IZIDimensions.ONE_UNIT_SIZE * 20,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.productsMap.values.toList()[index].length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: () {
                        controller.countProducts(
                          context,
                          product: controller.productsMap.values.toList()[index][position],
                        );
                      },
                      child: ProductCard(
                        image: controller.productsMap.values.toList()[index][position].thumbnail.toString(),
                        name: controller.productsMap.values.toList()[index][position].name.toString(),
                        onTap: () {
                          controller.onAddProduct(
                            context,
                            product: controller.productsMap.values.toList()[index][position],
                          );
                        },
                        price: IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.productsMap.values.toList()[index][position].price)),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      );
    });
  }
}
