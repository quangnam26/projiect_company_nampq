// ignore_for_file: prefer_if_elements_to_conditional_expressions

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/routes/route_path/detail_page_router.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/components/comom_item_view_page.dart';
import 'package:template/view/screen/components/display_ListView_or_GridView.dart';
import 'package:template/view/screen/detailproducts/custom_slider.dart';
import 'package:template/view/screen/detailproducts/detail_products_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:html/parser.dart' show parse;
import '../../../base_widget/izi_text.dart';
import '../dash_board/dash_board_controller.dart';

class DetailProductsPage extends GetView<DetailProductsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailProductsController>(
      // init: DetailProductsController(),
      builder: (DetailProductsController controller) => IZIScreen(
        background: const BackgroundAppBar(),
        physics: const ClampingScrollPhysics(),
        safeAreaBottom: false,
        appBar: IZIAppBar(
          title: IZIValidate.nullOrEmpty(controller.productResponse.value.name)
              ? ""
              : controller.productResponse.value.name!,
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
        body: ValueListenableBuilder(
          valueListenable: controller.productResponse,
          builder: (_, value, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detailSilder(controller),
                heading(),
                informationProducts(controller),
                controller.rateResponseList.isEmpty
                    ? Padding(
                        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                        child: const SizedBox(
                            child: IZIText(text: "Hiện tại chưa có đánh giá ")),
                      )
                    : productReviews(),
                relatedProducts(context),
              ],
            );
          },
        ),
        bottomNavigator: Container(
          margin: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_3X,
            vertical: IZIDimensions.SPACE_SIZE_1X,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.onPayment();
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorResources.ORANGE),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                    child: ValueListenableBuilder<int>(
                      valueListenable: controller.amountProductInCart,
                      builder: (_, value, __) {
                        return Badge(
                          badgeContent: Text(
                            value.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: ColorResources.WHITE,
                              fontSize: IZIDimensions.FONT_SIZE_H6,
                            ),
                          ),
                          showBadge: value > 0,
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: ColorResources.ORANGE,
                            size: IZIDimensions.FONT_SIZE_H6 * 2,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              Expanded(
                child: IZIButton(
                  height: 40,
                  borderRadius: 5,
                  label: 'Mua ngay',
                  colorBG: ColorResources.ORANGE,
                  onTap: () {
                    IZIValidate.nullOrEmpty(controller.idUser)
                        ? Get.find<DashBoardController>().checkLogin()
                        : showModalBottomSheet<void>(
                            // isDismissible: true,
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return GetBuilder<DetailProductsController>(
                                init: DetailProductsController(),
                                builder: (DetailProductsController controller) {
                                  return buyNowBottomSheet(
                                      controller.productResponse.value);
                                },
                              );
                            },
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// relateProducts
  ///
  Widget relatedProducts(BuildContext context) {
    return Container(
      color: ColorResources.NEUTRALS_11,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DisplayListViewOrGridViewPage(
            controller.productResponseRelatedList,
            "Sản phẩm liên quan",
            "",
            itemWidget: (index) {
              return CommomItemViewPage(
                  onTapDetail: () {
                    controller.onTapProduct(
                        productResponse:
                            controller.productResponseRelatedList[index]);
                  },
                  productResponse: controller.productResponseRelatedList[index],
                  image: controller.productResponseRelatedList[index].thumbnail,
                  ratingNumberAvg: double.parse((controller
                              .productResponseRelatedList[index].totalPoint! /
                          controller
                              .productResponseRelatedList[index].countRate!)
                      .toString()),
                  discountPercent:
                      "${controller.productResponseRelatedList[index].discountPercent!}",
                  name: controller.productResponseRelatedList[index].name,
                  price:
                      "${IZIPrice.currencyConverterVND(controller.productResponseRelatedList[index].price!)}đ",
                  // discountPercent: "${controller.productResponseRelatedList[index].discountPercent!}",
                  // name: controller.productResponseRelatedList[index].name,
                  // price: "đ ${IZIPrice.currencyConverterVND(controller.productResponseRelatedList[index].price!)}",
                  promotionalPrice:
                      '${IZIPrice.currencyConverterVND(controller.getPromotionWithProduct(controller.productResponseRelatedList[index]))}đ',
                  star: star(
                      controller.productResponseRelatedList[index].totalPoint!,
                      controller.productResponseRelatedList[index].countRate!),
                  countSold:
                      "${controller.productResponseRelatedList[index].countSold}");
            },
            onTapRight: () {},
            heightListView: IZIDimensions.ONE_UNIT_SIZE * 435,
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),
        ],
      ),
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
  ///byNow
  ///
  Widget buyNowBottomSheet(ProductResponse productResponse) {
    return Container(
      height: IZIDimensions.iziSize.height / 1.4,
      color: ColorResources.WHITE,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: IZIDimensions.SPACE_SIZE_2X,
                vertical: IZIDimensions.SPACE_SIZE_2X,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.BLUR_RADIUS_2X),
                    child: SizedBox(
                      height: IZIDimensions.ONE_UNIT_SIZE * 180,
                      width: IZIDimensions.ONE_UNIT_SIZE * 180,
                      child: IZIImage(productResponse.thumbnail!),
                    ),
                  ),
                  SizedBox(
                    width: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            IZIPrice.currencyConverterVND(
                                productResponse.price!),
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                              color: ColorResources.NEUTRALS_5,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(
                            width: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          Obx(() {
                            print("ACM:${controller.extraPrice.value}");
                            return Text(
                              '${IZIPrice.currencyConverterVND(controller.extraPrice.value + controller.getMoneyHavePromote())}đ',
                              style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                                  color: ColorResources.RED,
                                  fontWeight: FontWeight.w600),
                            );
                          }),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
                        child: ValueListenableBuilder<int>(
                          valueListenable: controller.stock,
                          builder: (_, value, __) {
                            return RichText(
                              text: TextSpan(
                                text: 'kho : ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: ColorResources.BLACK,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: value.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(
              height: IZIDimensions.ONE_UNIT_SIZE * 3,
              color: ColorResources.GREY,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: IZIDimensions.SPACE_SIZE_4X,
                  horizontal: IZIDimensions.SPACE_SIZE_3X),
              child: Text(
                "Màu sắc",
                style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Wrap(
                runSpacing: IZIDimensions.SPACE_SIZE_4X, // gap between lines
                spacing: IZIDimensions.SPACE_SIZE_4X,
                children: productResponse.colorsOption!.map<Widget>(
                  (e) {
                    return GestureDetector(
                      onTap: () {
                        controller.onChangeColor(e);
                      },
                      child: Container(
                        // height: IZIDimensions.ONE_UNIT_SIZE * 65,
                        width: IZIDimensions.ONE_UNIT_SIZE * 160,
                        //   //  (IZIDimensions.iziSize.width / 3) - (20 / 3),
                        decoration: BoxDecoration(
                          color: e == controller.selectedColor
                              ? ColorResources.YELLOW2
                              : ColorResources.NEUTRALS_11,
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BLUR_RADIUS_2X,
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      IZIDimensions.BLUR_RADIUS_1X),
                                  child: IZIImage(
                                    e.image.toString(),
                                    height: IZIDimensions.ONE_UNIT_SIZE * 40,
                                    width: IZIDimensions.ONE_UNIT_SIZE * 70,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  e.name.toString(),
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: ColorResources.NEUTRALS_5,
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: IZIDimensions.SPACE_SIZE_4X * 1.3,
                  left: IZIDimensions.SPACE_SIZE_3X,
                  bottom: IZIDimensions.SPACE_SIZE_3X),
              child: Text(
                "Size",
                style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                ...List.generate(
                  productResponse.sizesOption!.length,
                  (index) => GestureDetector(
                    onTap: () {
                      controller
                          .onChangeSized(productResponse.sizesOption![index]);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: IZIDimensions.SPACE_SIZE_4X,
                          bottom: IZIDimensions.SPACE_SIZE_2X),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              IZIDimensions.BLUR_RADIUS_1X),
                          color: controller.selectedSize ==
                                  productResponse.sizesOption![index]
                              ? ColorResources.YELLOW2
                              : ColorResources.NEUTRALS_6),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: IZIDimensions.SPACE_SIZE_4X,
                            horizontal: IZIDimensions.SPACE_SIZE_4X),
                        child: Text(
                          productResponse.sizesOption![index].name!,
                          style: TextStyle(
                              color: controller.selectedSize ==
                                      productResponse.sizesOption![index]
                                  ? ColorResources.ORANGE
                                  : ColorResources.GREY,
                              fontSize: IZIDimensions.FONT_SIZE_H6,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.SPACE_SIZE_3X,
                  vertical: IZIDimensions.SPACE_SIZE_2X),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Số lượng",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: IZIDimensions.ONE_UNIT_SIZE * 120,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Spacer(),
                        ValueListenableBuilder<int>(
                            valueListenable: controller.stock,
                            builder: (_, value, __) {
                              return Container(
                                constraints: BoxConstraints(
                                  minWidth: IZIDimensions.ONE_UNIT_SIZE * 180,
                                ),
                                child: IZIInput(
                                  type: IZIInputType.INCREMENT,
                                  width: IZIDimensions.ONE_UNIT_SIZE * 100,
                                  onChanged: (val) {
                                    controller.quantityChanged = int.parse(val);
                                  },
                                  max: value * 1.0,
                                  allowEdit: false,
                                  widthIncrement:
                                      IZIDimensions.ONE_UNIT_SIZE * 50,
                                  height: IZIDimensions.ONE_UNIT_SIZE * 50,
                                  fillColor: ColorResources.WHITE,
                                  colorBorder: ColorResources.PRIMARY_3,
                                  style: const TextStyle(
                                    color: ColorResources.NEUTRALS_1,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<int>(
              valueListenable: controller.stock,
              builder: (_, value, __) {
                return IZIButton(
                  margin: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_4X,
                    vertical: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  onTap: () {
                    controller.addProductToCart(
                        cartId: controller.cart.value.id.toString());
                  },
                  label: value > 0 ? 'Thêm vào giỏ hàng' : 'Hết hàng',
                  isEnabled: value > 0,
                  colorBG: ColorResources.ORANGE,
                  colorText:
                      value > 0 ? ColorResources.WHITE : ColorResources.BLACK,
                  colorBGDisabled: ColorResources.NEUTRALS_5,
                  borderRadius: IZIDimensions.BLUR_RADIUS_3X,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  ///
  /// productReviews
  ///
  Container productReviews() {
    return Container(
      color: ColorResources.WHITE,
      child: Padding(
        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Đánh giá sản phẩm ",
                    style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(DetailPageRoutes.PRODUCTS_REVIEW,
                        arguments: controller.productResponse.value.id);
                  },
                  child: Text(
                    "Xem tất cả >",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                      color: ColorResources.RED_COLOR_2,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: IZIDimensions.SPACE_SIZE_2X,
              ),
              child: controller.productResponse.value.countRate ==
                          int.parse("0") ||
                      double.parse((controller
                                      .productResponse.value.totalPoint! /
                                  controller.productResponse.value.countRate!)
                              .toString()) ==
                          0
                  ? const Text('Chưa có đánh giá')
                  : Row(
                      children: [
                        RatingBarIndicator(
                          rating: controller.productResponse.value.countRate ==
                                  int.parse("0")
                              ? 0
                              : double.parse((controller
                                          .productResponse.value.totalPoint! /
                                      controller
                                          .productResponse.value.countRate!)
                                  .toString()),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: ColorResources.YELLOW_PRIMARY2,
                          ),
                          itemSize: IZIDimensions.ONE_UNIT_SIZE * 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: IZIDimensions.SPACE_SIZE_2X),
                          child: Text(
                            double.parse((controller
                                            .productResponse.value.totalPoint! /
                                        controller
                                            .productResponse.value.countRate!)
                                    .toString())
                                .toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                              color: ColorResources.NEUTRALS_3,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: IZIDimensions.ONE_UNIT_SIZE * 8),
                          child: RichText(
                            text: TextSpan(
                              text:
                                  '(${controller.productResponse.value.countRate}',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: ColorResources.BLACK,
                                fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                              ),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: ' lượt đánh giá)',
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: IZIDimensions.SPACE_SIZE_1X,
                      left: IZIDimensions.SPACE_SIZE_1X,
                      bottom: IZIDimensions.SPACE_SIZE_1X,
                      right: IZIDimensions.SPACE_SIZE_4X),
                  child: Container(
                    height: IZIDimensions.ONE_UNIT_SIZE * 75,
                    width: IZIDimensions.ONE_UNIT_SIZE * 75,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(
                        controller.rateResponseList.first.user!.avatar ?? "",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.rateResponseList.first.user?.fullName ??
                            "Unknow",
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: IZIDimensions.ONE_UNIT_SIZE * 5),
                      RatingBarIndicator(
                        itemPadding: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.ONE_UNIT_SIZE * 0),
                        rating: IZINumber.parseDouble(
                            controller.rateResponseList.first.point),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: ColorResources.YELLOW_PRIMARY2,
                        ),
                        itemSize: IZIDimensions.ONE_UNIT_SIZE * 30,
                        // unratedColor: Colors.amber.withAlpha(50),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_2X),
              child: Text(
                "Đánh giá sản phẩm quá tốt",
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            IZIValidate.nullOrEmpty([
              ...controller.rateResponseList.first.image!,
              ...controller.rateResponseList.first.video!
            ])
                ? const SizedBox()
                : Container(
                    margin:
                        EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_1X),
                    height: IZIDimensions.ONE_UNIT_SIZE * 120,
                    width: IZIDimensions.iziSize.width,
                    child: Row(
                      children: [
                        IZIImage(
                          controller.rateResponseList.first.image!.first
                              .toString(),
                          width: 80,
                          height: 80,
                        ),
                        if (!IZIValidate.nullOrEmpty(
                            controller.videoController))
                          Stack(
                            children: [
                              FutureBuilder<void>(
                                  future: controller.initializeControllerFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return AspectRatio(
                                          aspectRatio: 16 / 12,
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: IZIDimensions
                                                      .SPACE_SIZE_2X),
                                              child: VideoPlayer(controller
                                                  .videoController!)));
                                    } else {
                                      return SizedBox(
                                          width:
                                              IZIDimensions.iziSize.width * .15,
                                          height:
                                              IZIDimensions.iziSize.width * .15,
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator()));
                                    }
                                  }),
                              GestureDetector(
                                onTap: () {
                                  controller.buttonOnOffVideo(
                                      controller.videoController!);
                                },
                                child: Icon(
                                  controller.videoController!.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: ColorResources.RED,
                                ),
                              )
                            ],
                          )
                      ],
                    ),
                  ),
            Text(
              IZIDate.formatDate(
                  IZIDate.parse(controller.rateResponseList.first.createdAt!)),
              style: TextStyle(
                color: ColorResources.NEUTRALS_4,
                fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      ),
    );
  }

  ///
  /// informationProducts
  ///
  Container informationProducts(DetailProductsController controller) {
    return Container(
      color: ColorResources.NEUTRALS_11,
      child: Padding(
        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thông tin sản phẩm",
              style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_1X),
              child: Text(
                IZIValidate.nullOrEmpty(
                        controller.productResponse.value.content)
                    ? ""
                    : parse(controller.productResponse.value.content.toString())
                        .documentElement!
                        .text,
                maxLines: controller.descTextShowFlag ? 8 : 4,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                    fontWeight: FontWeight.w400),
              ),
            ),
            InkWell(
              onTap: () {
                controller.onPressViewMoreOrShort();
              },
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      controller.descTextShowFlag
                          ? Text(
                              "Thu gọn",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                              ),
                            )
                          : Text(
                              "Xem thêm",
                              style: TextStyle(
                                color: ColorResources.RED_COLOR_2,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                              ),
                            )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///
  /// NIKE ARI Zoom
  ///
  Container heading() {
    return Container(
      color: ColorResources.WHITE2,
      child: Padding(
        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    IZIValidate.nullOrEmpty(
                            controller.productResponse.value.name)
                        ? ""
                        : controller.productResponse.value.name!,
                    style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.favorite();
                  },
                  child: ValueListenableBuilder<bool>(
                    valueListenable: controller.isFavorite,
                    builder: (_, value, __) {
                      return Icon(
                        value
                            ? Icons.favorite_outlined
                            : Icons.favorite_border_outlined,
                        color: value ? ColorResources.RED : ColorResources.GREY,
                      );
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_2X * 1.2,
                top: IZIDimensions.SPACE_SIZE_2X,
              ),
              child: Row(
                children: [
                  RatingBarIndicator(
                    itemPadding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.ONE_UNIT_SIZE * 0,
                    ),
                    rating: IZIValidate.nullOrEmpty(
                            controller.productResponse.value.name)
                        ? 0
                        : controller.productResponse.value.countRate ==
                                int.parse("0")
                            ? 0
                            : double.parse((controller
                                        .productResponse.value.totalPoint! /
                                    controller.productResponse.value.countRate!)
                                .toString()),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: ColorResources.YELLOW_PRIMARY2,
                    ),
                    itemSize: IZIDimensions.ONE_UNIT_SIZE * 30,
                    // unratedColor: Colors.amber.withAlpha(50),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_2X),
                    child: Text(
                      IZIValidate.nullOrEmpty(
                              controller.productResponse.value.countSold)
                          ? ""
                          : "${controller.productResponse.value.countSold} lượt mua",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                        color: ColorResources.RED_COLOR_2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  IZIValidate.nullOrEmpty(
                          controller.productResponse.value.price)
                      ? ""
                      : "${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.productResponse.value.price))}đ",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    color: ColorResources.NEUTRALS_13,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_4X,
                ),
                Text(
                  IZIValidate.nullOrEmpty(
                          controller.productResponse.value.price)
                      ? ""
                      : '${IZIPrice.currencyConverterVND(controller.getMoneyHavePromote())}đ',
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    color: ColorResources.RED,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ///
  ///Nike ARI
  ///
  Widget detailSilder(DetailProductsController controller) {
    return Stack(
      children: [
        IZIValidate.nullOrEmpty(controller.productResponse.value.images)
            ? SizedBox(
                width: IZIDimensions.iziSize.width,
                child: Align(
                  child: SizedBox(
                    height: 300,
                    child: IZIImage(
                      controller.productResponse.value.thumbnail ?? '',
                    ),
                  ),
                ),
              )
            : CustomIZISlider(
                data: controller.productResponse.value.images ?? [],
              ),
      ],
    );
  }
}
