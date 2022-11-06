import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/order/order_history_response.dart';
import 'package:template/data/model/order/order_request.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/screen/components/order_product_card.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../helper/izi_text_style.dart';
import '../../../utils/color_resources.dart';

class PreviewOrderBottomSheet extends StatelessWidget {
  PreviewOrderBottomSheet({
    Key? key,
    required this.name,
    required this.orderRequest,
    required this.amount,
    required this.distance,
    required this.promotion,
  }) : super(key: key);

  final String name;
  final OrderHistoryResponse orderRequest;
  int? amount;
  String? distance;
  double? promotion;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: IZIDimensions.iziSize.height * 0.8,
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_4X,
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  width: IZIDimensions.iziSize.width,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        child: Text(
                          name,
                          style: textStyleH3.copyWith(
                            color: ColorResources.NEUTRALS_2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: ColorResources.NEUTRALS_4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          Column(
                            children: [
                              ...List.generate(
                                orderRequest.idProducts!.length,
                                (index) {
                                  return product(
                                    amount: orderRequest
                                            .idProducts![index].amount ??
                                        0,
                                    name: IZIValidate.nullOrEmpty(orderRequest
                                            .idProducts![index].idProduct)
                                        ? ''
                                        : orderRequest.idProducts![index]
                                                .idProduct!.name ??
                                            '',
                                    note: IZIValidate.nullOrEmpty(orderRequest
                                            .idProducts![index].description)
                                        ? ''
                                        : orderRequest.idProducts![index]
                                                .description ??
                                            '',
                                    price: IZIValidate.nullOrEmpty(
                                            orderRequest.totalPrice)
                                        ? ''
                                        : IZIValidate.nullOrEmpty(orderRequest
                                                .idProducts![index].idProduct)
                                            ? ''
                                            : IZIPrice.currencyConverterVND(
                                                IZINumber.parseDouble(
                                                    orderRequest
                                                            .idProducts![index]
                                                            .idProduct!
                                                            .price! *
                                                        orderRequest
                                                            .idProducts![index]
                                                            .amount!)),
                                    toppings: IZIValidate.nullOrEmpty(
                                            orderRequest.idProducts![index]
                                                .optionsTopping)
                                        ? ''
                                        : orderRequest
                                            .idProducts![index].optionsTopping!
                                            .fold<String>('',
                                                (previousValue, element) {
                                            return previousValue +=
                                                ', ${element.topping!}';
                                          }).replaceFirst(', ', ''),
                                    onChanged: (val) {},
                                  );
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_4X,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          button(),
        ],
      ),
    );
  }

  Widget button() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
        vertical: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Column(
        children: [
          const Divider(
            color: ColorResources.PRIMARY_1,
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          bill(
            lable: 'Tạm tính ($amount món)',
            value: orderRequest.totalPrice,
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          bill(
            lable: 'Phí áp dụng: $distance',
            value: orderRequest.shipPrice,
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          if (!IZIValidate.nullOrEmpty(promotion))
            bill(
              lable: 'Ví DPPay giảm thêm',
              value: promotion,
              valueColor: ColorResources.PRIMARY_1,
              color: ColorResources.PRIMARY_1,
            ),
          const Divider(
            color: ColorResources.PRIMARY_1,
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          bill(
            lable: 'Tổng cộng',
            value: orderRequest.finalPrice,
            valueColor: ColorResources.PRIMARY_4,
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          bill(
            lable: 'Thanh toán bằng',
            value: orderRequest.typePayment == '0' ? "Ví DPPay" : 'Tiền mặt',
            valueColor: ColorResources.PRIMARY_1,
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
        ],
      ),
    );
  }

  Widget bill(
      {required String lable,
      required dynamic value,
      Color? color,
      Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          lable,
          style: textStyleH5.copyWith(
            color: color ?? ColorResources.NEUTRALS_3,
          ),
        ),
        Text(
          value is num
              ? '${IZIPrice.currencyConverterVND(value.toDouble())}đ'
              : value.toString(),
          style: textStyleH5.copyWith(
            color: valueColor ?? ColorResources.NEUTRALS_4,
          ),
        ),
      ],
    );
  }

  ///
  /// product
  ///
  Widget product({
    required int amount,
    required String name,
    required String note,
    required String price,
    required String toppings,
    required Function(String val) onChanged,
  }) {
    return ProductOrderCard(
      amount: amount,
      name: name,
      note: note,
      price: price,
      toppings: toppings,
      isShowDivider: true,
      onChanged: (val) {
        onChanged(val);
      },
      isShowCart: false,
    );
  }
}
