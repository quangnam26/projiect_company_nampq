import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_appbar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/data/model/address/address_response.dart';
import 'package:template/data/model/voucher/voucher_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/routes/route_path/payment_methods_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/cart/payment/payment_controller.dart';
import '../../../../helper/izi_number.dart';
import '../../../../routes/route_path/shipping_method_routes.dart';

class PaymentPage extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundAppBar(),
      appBar: const IZIAppBarP24(
        title: "Thanh toán",
      ),
      body: GetBuilder<PaymentController>(
        init: PaymentController(),
        builder: (_) => Column(
          children: [
            GestureDetector(
              onTap: () {
                controller.onGoToAdressDelivery();
              },
              child: Container(
                color: ColorResources.WHITE,
                margin: EdgeInsets.symmetric(
                  vertical: IZIDimensions.SPACE_SIZE_4X,
                ),
                padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_4X),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffF7F6F4),
                        borderRadius: BorderRadius.circular(
                          IZIDimensions.BORDER_RADIUS_3X,
                        ),
                      ),
                      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_4X),
                      child: const Icon(
                        Icons.location_on_outlined,
                        color: ColorResources.ORANGE,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              child: IZIText(
                                text: "Địa chỉ nhận hàng",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: ColorResources.NEUTRALS_2,
                                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            ValueListenableBuilder<AddressResponse>(
                              valueListenable: controller.address,
                              builder: (context, value, child) {
                                return IZIText(
                                  text:
                                      "${value.fullName ?? ''} - ${value.phone ?? ''} - ${controller.fullAddress(address: value)}",
                                  maxLine: 4,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: ColorResources.NEUTRALS_3,
                                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: ColorResources.NEUTRALS_13,
                    )
                  ],
                ),
              ),
            ),
            IZIListView(
              itemCount: controller.listCartPayment.length,
              builder: (index) => Container(
                margin: EdgeInsets.only(
                  top: IZIDimensions.SPACE_SIZE_2X,
                ),
                padding: EdgeInsets.all(
                  IZIDimensions.SPACE_SIZE_1X,
                ),
                decoration: const BoxDecoration(color: ColorResources.WHITE),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      child: IZIImage(
                        controller.listCartPayment[index].idProduct?.thumbnail ?? '',
                        width: IZIDimensions.ONE_UNIT_SIZE * 100,
                        height: IZIDimensions.ONE_UNIT_SIZE * 100,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_2X),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: IZIText(
                                    text: controller.listCartPayment[index].idProduct!.name ?? '',
                                    maxLine: 2,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: ColorResources.PRIMARY_9,
                                      fontSize: IZIDimensions.FONT_SIZE_SPAN * 1.1,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: IZIText(
                                    text:
                                        '${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.showPriceFollowPromotion(controller.listCartPayment[index])))}đ',
                                    maxLine: 2,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: ColorResources.PRICE,
                                      fontSize: IZIDimensions.FONT_SIZE_SPAN * 1.1,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'x${IZINumber.parseInt(controller.listCartPayment[index].quantityPrices?.quantity.toString()) == 0 ? '' : controller.listCartPayment[index].quantityPrices?.quantity.toString()}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: ColorResources.NEUTRALS_4,
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.gotoVoucher();
              },
              child: Container(
                padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_4X),
                margin: EdgeInsets.only(
                  top: IZIDimensions.SPACE_SIZE_5X,
                ),
                decoration: const BoxDecoration(
                  color: ColorResources.WHITE,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder<VoucherResponse>(
                      valueListenable: controller.voucher,
                      builder: (_, value, __) {
                        return IZIText(
                          text: controller.voucher.value.name ?? "Voucher của shop", //"Voucher của shop",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: ColorResources.PRIMARY_9,
                            fontSize: IZIDimensions.FONT_SIZE_SPAN,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                    Row(
                      children: [
                        ValueListenableBuilder<VoucherResponse>(
                            valueListenable: controller.voucher,
                            builder: (_, value, __) {
                              return IZIText(
                                text: controller.calulatorDiscountToCurrent() < 1000
                                    ? '-${IZIPrice.currencyConverterVND(controller.calulatorDiscountToCurrent())}đ'
                                    : '- ${IZIOther.formatterCurrent(controller.calulatorDiscountToCurrent()).toString()}', // '${controller.calulatorDiscount()}đ',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: ColorResources.ORANGE,
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }),
                        GestureDetector(
                          onTap: () {
                            controller.gotoVoucher();
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: ColorResources.NEUTRALS_5,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(ShippingMethodRoutes.SHIPPING_METHOD);
              },
              child: Container(
                margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_5X),
                padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_2X, vertical: IZIDimensions.SPACE_SIZE_4X),
                decoration: const BoxDecoration(color: ColorResources.WHITE),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(PaymentmethodsRoutes.PAYMENT_METHODS);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
                        child: IZIText(
                          text: "Phương thức vận chuyển",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: ColorResources.PRIMARY_9,
                            fontSize: IZIDimensions.FONT_SIZE_SPAN,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IZIText(
                            text: "Giao hàng nhanh",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: ColorResources.PRIMARY_8.withOpacity(.5),
                              fontSize: IZIDimensions.FONT_SIZE_SPAN,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          IZIText(
                            text: "0 đ",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: ColorResources.PRICE,
                              fontSize: IZIDimensions.FONT_SIZE_H6,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    IZIText(
                      text:
                          "Nhận hàng vào ${IZIDate.formatDate(DateTime.now(), format: 'dd/MM')} - ${IZIDate.formatDate(DateTime.now().add(const Duration(days: 3)), format: 'dd/MM')}",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: ColorResources.PRIMARY_8.withOpacity(.5),
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.onSelectedPaymentMethod();
              },
              child: Container(
                margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_5X),
                padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_2X, vertical: IZIDimensions.SPACE_SIZE_4X),
                decoration: const BoxDecoration(color: ColorResources.WHITE),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
                      child: IZIText(
                        text: "Phương thức thanh toán",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: ColorResources.PRIMARY_9,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: controller.paymentMethod,
                      builder: (_, value, __) {
                        return IZIText(
                          text: controller.getPaymentMethod(method: controller.paymentMethod.value),
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: ColorResources.PRIMARY_8.withOpacity(.5),
                            fontSize: IZIDimensions.FONT_SIZE_SPAN,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_5X),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_1X,
                      left: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    child: IZIText(
                      text: "Ghi chú nhận hàng",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: ColorResources.PRIMARY_9,
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_2X),
                    child: IZIInput(
                        fillColor: ColorResources.WHITE,
                        type: IZIInputType.TEXT,
                        placeHolder: "Ghi chú nhận hàng",
                        hintStyle: TextStyle(
                          fontFamily: 'Roboto',
                          color: const Color(0xffB1B1B1),
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (String val) {
                          controller.setNote = val;
                        }),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: ColorResources.WHITE),
              padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
              child: Column(
                children: [
                  boxFieldPay(
                    "Tổng tiền hàng",
                    "${IZIPrice.currencyConverterVND(controller.getTotalPrice())}VNĐ",
                    ColorResources.PRIMARY_8,
                    ColorResources.PRIMARY_9,
                  ),
                  boxFieldPay(
                    "Tiền giao hàng",
                    "${IZIPrice.currencyConverterVND(controller.transportsMethodPrice)}VNĐ",
                    ColorResources.PRIMARY_8,
                    ColorResources.PRIMARY_9,
                  ),
                  ValueListenableBuilder<VoucherResponse>(
                    valueListenable: controller.voucher,
                    builder: (_, value, __) {
                      return boxFieldPay(
                        "Tiền giảm giá",
                        "-${IZIPrice.currencyConverterVND(controller.calulatorDiscountToCurrent())} VNĐ",
                        ColorResources.PRIMARY_8,
                        ColorResources.PRIMARY_9,
                      );
                    },
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  boxFieldPay(
                    "Tổng tiền",
                    "${IZIPrice.currencyConverterVND(controller.getTotalPricePayment())} đ",
                    ColorResources.PRIMARY_8,
                    ColorResources.PRICE,
                  ),
                ],
              ),
            ),
            IZIButton(
              margin: EdgeInsets.all(
                IZIDimensions.SPACE_SIZE_4X,
              ),
              onTap: () {
                controller.onPayment();
              },
              colorBG: ColorResources.ORANGE,
              label: "Đặt hàng",
            ),
          ],
        ),
      ),
    );
  }

  Widget boxFieldPay(String? titleLeft, String? titleRight, Color? colorTitleLeft, Color? colorTitleRight) {
    return Padding(
      padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IZIText(
            text: titleLeft!,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                color: colorTitleLeft),
          ),
          IZIText(
            text: titleRight!,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: IZIDimensions.FONT_SIZE_H6, color: colorTitleRight),
          )
        ],
      ),
    );
  }
}
