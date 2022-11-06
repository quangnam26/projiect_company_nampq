import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/history_order/detail/detail_history_order_controller.dart';

import '../../../../base_widget/izi_loader_overlay.dart';

class DetailHistoryPage extends GetView<DetailHistoryOrderController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      appBar: const IZIAppBar(
        title: "Chi tiết đơn hàng",
        colorTitle: ColorResources.WHITE,
      ),
      background: const BackgroundAppBar(),
      body: GetBuilder(
        builder: (DetailHistoryOrderController controller) {
          return Obx(() {
            if (IZIValidate.nullOrEmpty(controller.orderResponse)) {
              return spinKitWave;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_3X),
              child: Column(
                children: [
                  Container(
                    width: IZISize.size.width,
                    decoration:
                        const BoxDecoration(color: ColorResources.WHITE),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        idOrderWidget(controller),
                        nameOrderWidget(controller),
                        dateTimeWidget(controller),
                        imageOrderWidget(controller),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: IZIDimensions.SPACE_SIZE_2X),
                    child: IZIListView(
                      itemCount:
                          controller.orderResponse.value.idProducts!.length,
                      builder: (id) => Container(
                        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                        decoration:
                            const BoxDecoration(color: ColorResources.WHITE),
                        margin:
                            EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IZIText(
                                text:
                                    "x${IZIValidate.nullOrEmpty(controller.orderResponse.value.idProducts![id].amount) ? '' : controller.orderResponse.value.idProducts![id].amount}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    color: ColorResources.AMOUNT)),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: IZIDimensions.SPACE_SIZE_1X),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: IZIDimensions.SPACE_SIZE_2X),
                                      child: IZIText(
                                          text:
                                              "${IZIValidate.nullOrEmpty(controller.orderResponse.value.idProducts![id].idProduct!.name) ? '' : controller.orderResponse.value.idProducts![id].idProduct!.name}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_H6,
                                              color: ColorResources.PRIMARY_2)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: IZIDimensions.SPACE_SIZE_1X),
                                      child: IZIText(
                                          text:
                                              "${IZIValidate.nullOrEmpty(controller.orderResponse.value.idProducts![id].idProduct!.description) ? '' : controller.orderResponse.value.idProducts![id].idProduct!.description}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_SPAN,
                                              color: ColorResources
                                                  .ADDRESS_ORDER)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: IZIDimensions.SPACE_SIZE_2X),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height:
                                                IZIDimensions.ONE_UNIT_SIZE *
                                                    20,
                                            width: IZIDimensions.ONE_UNIT_SIZE *
                                                20,
                                            child: IZIImage(
                                                ImagesPath.description),
                                          ),
                                          SizedBox(
                                            width: IZIDimensions.SPACE_SIZE_1X,
                                          ),
                                          IZIText(
                                            text:
                                                "${controller.onGetNameOptionSize(controller.orderResponse.value.idProducts![id].idProduct!.optionsSize!)} ${controller.onGetNameOptionTopping(controller.orderResponse.value.idProducts![id].idProduct!.optionsTopping!)}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_SPAN,
                                              color: ColorResources.NEUTRALS_4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IZIText(
                                        text:
                                            '${IZIPrice.currencyConverterVND(double.parse((controller.orderResponse.value.totalPrice).toString()))}đ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                                IZIDimensions.FONT_SIZE_SPAN,
                                            color: ColorResources.PRICE))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration:
                        const BoxDecoration(color: ColorResources.WHITE),
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                    child: Column(
                      children: [
                        boxFieldPay(
                            "Tạm tính",
                            "${IZIPrice.currencyConverterVND(double.parse(controller.orderResponse.value.totalPrice.toString()))}đ",
                            ColorResources.ADDRESS_ORDER,
                            ColorResources.ADDRESS_ORDER),
                        boxFieldPay(
                            "Phí áp dụng: ${IZIValidate.nullOrEmpty(controller.distance) ? '' : '(${controller.distance.value})'}",
                            "${IZIPrice.currencyConverterVND(double.parse("${controller.orderResponse.value.shipPrice}"))}đ",
                            ColorResources.ADDRESS_ORDER,
                            ColorResources.ADDRESS_ORDER),
                        boxFieldPay(
                            "Khuyến mãi",
                            "${IZIPrice.currencyConverterVND(double.parse("${controller.orderResponse.value.promotionPrice}"))}đ",
                            ColorResources.PRIMARY_1,
                            ColorResources.PRIMARY_1),
                        const Divider(
                          thickness: 2,
                        ),
                        boxFieldPay(
                            "Tổng cộng",
                            "${IZIPrice.currencyConverterVND(double.parse("${controller.orderResponse.value.finalPrice}"))}đ",
                            ColorResources.PRIMARY_2,
                            ColorResources.PRICE),
                        const Divider(
                          thickness: 2,
                        ),
                        boxFieldPay(
                            "Thanh toán bằng",
                            controller.orderResponse.value.typePayment == '0'
                                ? 'Ví DPPay'
                                : 'Tiền mặt',
                            ColorResources.PRIMARY_2,
                            ColorResources.PRIMARY_1),
                      ],
                    ),
                  ),
                  if (!controller.orderResponse.value.isReview! &&
                      controller.orderResponse.value.status ==
                          TRANG_THAI_DON_HANG_XAC_NHAN_GIAO)
                    IZIButton(
                      margin: EdgeInsets.only(
                          left: IZIDimensions.SPACE_SIZE_2X,
                          right: IZIDimensions.SPACE_SIZE_2X,
                          top: IZIDimensions.ONE_UNIT_SIZE * 100),
                      onTap: () {
                        controller.onToReview();
                      },
                      label: "Đánh giá",
                    ),
                ],
              ),
            );
          });
        },
      ),
    );
  }

  Align imageOrderWidget(DetailHistoryOrderController controller) {
    return Align(
      child: Image.network(
        IZIValidate.nullOrEmpty(
                controller.orderResponse.value.idUserShop!.banner)
            ? ''
            : controller.orderResponse.value.idUserShop!.banner.toString(),
        fit: BoxFit.cover,
      ),
      // child: IZIImage(
      //   ImagesPath.image_order_item,
      //   width: IZIDimensions.ONE_UNIT_SIZE * 200,
      // ),
    );
  }

  Container dateTimeWidget(DetailHistoryOrderController controller) {
    return Container(
        margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
        alignment: Alignment.center,
        child: IZIText(
            text: IZIDate.formatDate(
                IZIDate.parse(
                    controller.orderResponse.value.createdAt.toString()),
                format: 'HH:mm dd-MM-yyyy'),
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: IZIDimensions.FONT_SIZE_H6,
                color: ColorResources.ADDRESS_ORDER)));
  }

  Container nameOrderWidget(DetailHistoryOrderController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
      alignment: Alignment.center,
      child: IZIText(
        text: IZIValidate.nullOrEmpty(
                controller.orderResponse.value.idUserShop!.fullName)
            ? ''
            : controller.orderResponse.value.idUserShop!.fullName.toString(),
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: IZIDimensions.FONT_SIZE_H6 * 1.5,
            color: ColorResources.PRIMARY_2),
      ),
    );
  }

  Container idOrderWidget(DetailHistoryOrderController controller) {
    return Container(
      margin: EdgeInsets.only(
          top: IZIDimensions.SPACE_SIZE_2X, left: IZIDimensions.SPACE_SIZE_5X),
      child: IZIText(
        text: IZIValidate.nullOrEmpty(controller.orderResponse.value.codeOrder)
            ? ''
            : '#${controller.orderResponse.value.codeOrder.toString()}',
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: IZIDimensions.FONT_SIZE_SPAN,
            color: ColorResources.PRIMARY_2),
      ),
    );
  }

  Widget boxFieldPay(String? titleLeft, String? titleRight,
      Color? colorTitleLeft, Color? colorTitleRight) {
    return Padding(
      padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IZIText(
            text: titleLeft!,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                color: colorTitleLeft),
          ),
          IZIText(
            text: titleRight!,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                color: colorTitleRight),
          )
        ],
      ),
    );
  }
}
