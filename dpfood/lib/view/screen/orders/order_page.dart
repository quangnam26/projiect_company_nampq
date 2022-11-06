import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_text_style.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/orders/order_controller.dart';
import '../../../base_widget/izi_button.dart';
import '../../../base_widget/izi_image.dart';
import '../../../base_widget/izi_input.dart';
import '../components/coupons_widget.dart';
import '../components/order_product_card.dart';

class OrderPage extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading.isTrue
          ? IZILoaderOverLay(
              loadingWidget: spinKitWanderingCubes,
              body: const SizedBox(),
            )
          : IZIScreen(
              isSingleChildScrollView: false,
              background: Container(
                color: ColorResources.PRIMARY_1,
              ),
              safeAreaBottom: false,
              appBar: const IZIAppBar(
                title: "Trang thanh toán",
                colorBG: ColorResources.PRIMARY_1,
                colorTitle: ColorResources.WHITE,
              ),
              body: GetBuilder(
                builder: (OrderController controller) {
                  return GestureDetector(
                    onTap: () {
                      IZIOther.primaryFocus();
                    },
                    child: Container(
                      color: ColorResources.NEUTRALS_7,
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: SizedBox(
                          // padding: EdgeInsets.symmetric(
                          //   horizontal: IZIDimensions.SPACE_SIZE_4X,
                          // ),
                          child: Column(
                            children: [
                              address(),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              productList(),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              bill(),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              coupons(),
                              SizedBox(
                                height: MediaQuery.of(context).viewPadding.bottom + IZIDimensions.ONE_UNIT_SIZE * 200,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              widgetBottomSheet: Container(
                height: IZIDimensions.ONE_UNIT_SIZE * 220,
                decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      IZIDimensions.BORDER_RADIUS_5X,
                    ),
                    topRight: Radius.circular(
                      IZIDimensions.BORDER_RADIUS_5X,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.SPACE_SIZE_4X,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: paymentType(
                            name: "Ví DPPay",
                            val: 0,
                            groupValue: controller.payment.value,
                            marginRight: IZIDimensions.SPACE_SIZE_2X,
                            onTap: () {
                              controller.changePayment(0);
                            },
                          ),
                        ),
                        Expanded(
                          child: paymentType(
                            name: "Tiền mặt",
                            val: 1,
                            groupValue: controller.payment.value,
                            marginRight: 0,
                            onTap: () {
                              controller.changePayment(1);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() {
                                return (IZINumber.parseDouble(controller.orderRequest!.value.promotionPrice) != IZINumber.parseDouble(controller.orderRequest!.value.finalPrice) && controller.voucher.value.id != null)
                                    ? Text(
                                        "${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.orderRequest!.value.promotionPrice))}đ",
                                        style: textStyleSpan.copyWith(
                                          color: ColorResources.NEUTRALS_4,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      )
                                    : const SizedBox();
                              }),
                              Obx(() {
                                return Text(
                                  controller.voucher.value.id != null ? '${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.orderRequest!.value.finalPrice))}đ' : '${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.orderRequest!.value.finalPrice))}đ',
                                  style: textStyleH5.copyWith(
                                    color: ColorResources.PRIMARY_1, //ColorResources.NEUTRALS_1,
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                        Expanded(
                          child: IZIButton(
                            onTap: () {
                              controller.onPayment();
                            },
                            borderRadius: 5,
                            label: "Đặt hàng",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
    });
  }

  Widget paymentType({
    required String name,
    required int val,
    required int groupValue,
    required double marginRight,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(
          IZIDimensions.SPACE_SIZE_2X,
        ),
        margin: EdgeInsets.only(
          right: marginRight,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: val == groupValue ? ColorResources.PRIMARY_1 : ColorResources.NEUTRALS_5,
            width: 0.8,
          ),
        ),
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: textStyleH6.copyWith(
            color: val == groupValue ? ColorResources.PRIMARY_1 : ColorResources.NEUTRALS_5,
          ),
        ),
      ),
    );
  }

  ///
  ///  coupon list
  ///
  Widget coupons() {
    return Obx(() {
      if (controller.vouchers.isEmpty) {
        return const SizedBox();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 140,
            child: ListView.builder(
              itemCount: controller.vouchers.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Obx(() {
                  return CouponsWidget(
                    onTap: () {
                      controller.onSelecteVoucher(
                        controller.vouchers[index],
                      );
                    },
                    enable: IZINumber.parseDouble(controller.orderRequest!.value.totalPrice) > IZINumber.parseDouble(controller.vouchers[index].minOrderPrice),
                    bg: controller.vouchers[index].id == controller.voucher.value.id
                        ? ColorResources.PRIMARY_3
                        : IZINumber.parseDouble(controller.orderRequest!.value.totalPrice) > IZINumber.parseDouble(controller.vouchers[index].minOrderPrice)
                            ? null
                            : ColorResources.NEUTRALS_5,
                    code: controller.vouchers[index].code.toString(),
                    description: controller.vouchers[index].name.toString(),
                    expiration: IZIDate.formatDate(DateTime.fromMillisecondsSinceEpoch(controller.vouchers[index].toDate!)),
                  );
                });
              },
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: GestureDetector(
              onTap: () {
                controller.onTapMoreCoupons();
              },
              child: Text(
                "Xem thêm mã coupon >> ",
                style: textStyleSpanCustom.copyWith(
                  color: ColorResources.PRIMARY_1,
                ),
              ),
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
        ],
      );
    });
  }

  ///
  /// bill
  ///
  Widget bill() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
        vertical: IZIDimensions.SPACE_SIZE_2X,
      ),
      color: ColorResources.WHITE,
      child: Column(
        children: [
          IZIInput(
            type: IZIInputType.TEXT,
            placeHolder: 'Lời nhắn cho cửa hàng...',
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            onChanged: (val) {
              controller.note = val;
            },
            prefixIcon: (val) {
              return Container(
                margin: EdgeInsets.only(
                  right: IZIDimensions.SPACE_SIZE_1X,
                ),
                width: IZIDimensions.ONE_UNIT_SIZE * 20,
                height: IZIDimensions.ONE_UNIT_SIZE * 20,
                child: IZIImage(
                  ImagesPath.note_store,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
          const Divider(
            thickness: 0.2,
            color: ColorResources.PRIMARY_1,
          ),
          billContent(
            title: 'Tạm tính (${controller.calculatorFood(controller.orderRequest!.value)} món)',
            double: IZINumber.parseDouble(controller.orderRequest!.value.totalPrice),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Obx(() {
            return billContent(
              title: 'Phí áp dụng: ${controller.distance}',
              double: controller.distanceFee.value,
            );
          }),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Obx(
            () {
              return billContent(
                title: 'DPFood khao bạn thêm',
                double: controller.voucher.value.id == null ? 0 : controller.voucher.value.discountMoney!,
                color: ColorResources.PRIMARY_1,
              );
            },
          ),
        ],
      ),
    );
  }

  /// Bill
  Widget billContent({required String title, required double double, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textStyleH6.copyWith(
            color: color ?? ColorResources.NEUTRALS_2,
          ),
        ),
        Text(
          '${IZIPrice.currencyConverterVND(double)}đ',
          style: textStyleH6.copyWith(
            color: color ?? ColorResources.NEUTRALS_4,
          ),
        ),
      ],
    );
  }

  ///
  /// address
  ///
  Widget address() {
    return Container(
      padding: EdgeInsets.only(
        left: IZIDimensions.SPACE_SIZE_4X,
        right: IZIDimensions.SPACE_SIZE_4X,
        top: IZIDimensions.SPACE_SIZE_4X * 3,
        bottom: IZIDimensions.SPACE_SIZE_2X * 2,
      ),
      color: ColorResources.WHITE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Giao bởi tài xế",
                style: textStyleH6.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Thay đổi",
                style: textStyleH6.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          GestureDetector(
            onTap: () {
              controller.toChangeAddress();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.ONE_UNIT_SIZE * 100,
                  ),
                  child: SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 100,
                    width: IZIDimensions.ONE_UNIT_SIZE * 100,
                    child: IZIImage(
                      ImagesPath.shipper,
                    ),
                  ),
                ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_1X,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              return Text(
                                controller.userResponse.value.address ?? '',
                                maxLines: 2,
                                style: textStyleH5.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorResources.NEUTRALS_1,
                                ),
                              );
                            }),
                            Text(
                              controller.userResponse.value.note ?? "+ Thêm vào tòa nhà, tầng, số phòng.",
                              maxLines: 2,
                              style: textStyleSpanCustom.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorResources.NEUTRALS_4,
                                fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorResources.NEUTRALS_4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// danh sách sản phẩm
  ///
  Widget productList() {
    return Obx(
      () {
        return Container(
          color: ColorResources.WHITE,
          padding: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_4X,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: IZIDimensions.SPACE_SIZE_1X,
                  horizontal: IZIDimensions.SPACE_SIZE_4X * 1.8,
                ),
                child: Text(
                  "Đơn hàng của bạn",
                  style: textStyleH6.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.isExpan.isFalse
                    ? controller.orderRequest!.value.idProducts!.length > 3
                        ? 3
                        : controller.orderRequest!.value.idProducts!.length
                    : controller.orderRequest!.value.idProducts!.length + 1,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  if (controller.isExpan.isFalse ? index == 2 : index == controller.orderRequest!.value.idProducts!.length) {
                    return GestureDetector(
                      onTap: () {
                        controller.onExpaned();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.isExpan.isFalse ? "Xem thêm" : "Thu gọn",
                              style: textStyleSpan.copyWith(
                                color: ColorResources.PRIMARY_1,
                              ),
                            ),
                            Icon(
                              controller.isExpan.isFalse ? Icons.keyboard_double_arrow_down_rounded : Icons.keyboard_double_arrow_up_rounded,
                              color: ColorResources.PRIMARY_1,
                              size: IZIDimensions.ONE_UNIT_SIZE * 22,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return ProductOrderCard(
                    isShowCart: false,
                    amount: IZIValidate.nullOrEmpty(controller.orderRequest!.value.idProducts) ? 0 : controller.orderRequest!.value.idProducts![index].amount ?? 0,
                    name: IZIValidate.nullOrEmpty(controller.orderRequest!.value.idProducts![index].idProduct)
                        ? ''
                        : IZIValidate.nullOrEmpty(controller.orderRequest!.value.idProducts)
                            ? ''
                            : controller.orderRequest!.value.idProducts![index].idProduct!.name ?? '',
                    note: IZIValidate.nullOrEmpty(controller.orderRequest!.value.idProducts![index].description)
                        ? ''
                        : IZIValidate.nullOrEmpty(controller.orderRequest!.value.idProducts)
                            ? ''
                            : controller.orderRequest!.value.idProducts![index].description ?? '',
                    price: IZIValidate.nullOrEmpty(controller.orderRequest!.value.totalPrice)
                        ? ''
                        : IZIValidate.nullOrEmpty(controller.orderRequest!.value.idProducts![index].idProduct)
                            ? ''
                            : IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.orderRequest!.value.idProducts![index].price! * controller.orderRequest!.value.idProducts![index].amount!)),
                    toppings: controller.getToppings(orderProduct: controller.orderRequest!.value.idProducts![index]),
                    onChanged: (val) {},
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
