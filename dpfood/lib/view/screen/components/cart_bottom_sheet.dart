import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/order/order_product/order_product.dart';
import 'package:template/data/model/order/order_request.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/screen/components/order_product_card.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../helper/izi_text_style.dart';
import '../../../utils/color_resources.dart';

class CartBottomSheet extends StatelessWidget {
  CartBottomSheet({
    Key? key,
    required this.onTap,
    required this.onClearCart,
    required this.orderRequest,
    required this.onUpdateCart,
  }) : super(key: key);

  final Function onTap;
  final Function onClearCart;
  final OrderRequest orderRequest;
  RxInt count = 0.obs;
  final Function(int index) onUpdateCart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: IZIDimensions.iziSize.height * 0.7,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_4X,
                      vertical: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: ColorResources.NEUTRALS_4,
                          ),
                        ),
                        Text(
                          'Giỏ hàng',
                          style: textStyleH6.copyWith(
                            color: ColorResources.NEUTRALS_2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            onClearCart();
                          },
                          child: Text(
                            'Xóa',
                            style: textStyleSpan.copyWith(
                              color: ColorResources.RED,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        Obx(
                          () {
                            return count.value >= 0
                                ? Column(
                                    children: [
                                      ...List.generate(
                                        orderRequest.idProducts!.length,
                                        (index) {
                                          return product(
                                            amount: orderRequest.idProducts![index].amount ?? 0,
                                            name: IZIValidate.nullOrEmpty(orderRequest.idProducts![index].idProduct) ? '' : orderRequest.idProducts![index].idProduct!.name ?? '',
                                            note: IZIValidate.nullOrEmpty(orderRequest.idProducts![index].description) ? '' : orderRequest.idProducts![index].description ?? '',
                                            price: IZIValidate.nullOrEmpty(orderRequest.totalPrice)
                                                ? ''
                                                : IZIValidate.nullOrEmpty(orderRequest.idProducts![index].idProduct)
                                                    ? ''
                                                    : IZIPrice.currencyConverterVND(IZINumber.parseDouble(orderRequest.idProducts![index].price! * orderRequest.idProducts![index].amount!)),
                                            toppings: getToppings(orderProduct: orderRequest.idProducts![index]),
                                            onChanged: (val) {
                                              if (val == '0') {
                                                count.value++;
                                                onUpdateCart(index);
                                              } else {
                                                orderRequest.idProducts![index].amount = IZINumber.parseInt(val);
                                              }
                                              count.value++;
                                              orderRequest.totalPrice = total();
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  )
                                : const SizedBox();
                          },
                        ),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          button(context),
        ],
      ),
    );
  }

  double total() {
    double total = 0.0;
    for (final OrderProduct element in orderRequest.idProducts!) {
      total += element.price! * element.amount!;
    }
    return total;
  }

  ///
  /// Toppings
  ///
  String getToppings({required OrderProduct orderProduct}) {
    String toppings = '';
    print(orderProduct.optionsSize?.toJson());
    if (!IZIValidate.nullOrEmpty(orderProduct.optionsSize)) {
      toppings = !IZIValidate.nullOrEmpty(orderProduct.optionsTopping) ? 'Size ${orderProduct.optionsSize!.size},' : 'Size ${orderProduct.optionsSize!.size}';
    }
    if (!IZIValidate.nullOrEmpty(orderProduct.optionsTopping)) {
      final dataSet = orderProduct.optionsTopping!.map((e) => e.topping).toSet();
      toppings += dataSet.fold<String>('', (val, e) {
        final amount = orderProduct.optionsTopping?.where((element) => element.topping.toString().contains(e.toString())).length;
        return val += (amount!) > 1 ? ',x$amount $e' : ',$e';
      }).replaceFirst(',', '');
    }

    return toppings;
  }

  Widget button(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewPadding.bottom,
      ),
      color: ColorResources.WHITE,
      height: IZIDimensions.ONE_UNIT_SIZE * 80 + MediaQuery.of(context).viewPadding.bottom,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(
              IZIDimensions.SPACE_SIZE_2X,
            ),
            margin: EdgeInsets.only(
              left: IZIDimensions.SPACE_SIZE_4X,
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
                  count.value >= 0 ? '${IZIValidate.nullOrEmpty(orderRequest.idProducts) ? '' : orderRequest.idProducts!.length}' : '0',
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
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_2X,
          ),
          Expanded(
            child: Obx(() {
              return count.value >= 0
                  ? Text(
                      IZIValidate.nullOrEmpty(orderRequest.idProducts) ? '' : '${IZIPrice.currencyConverterVND(IZINumber.parseDouble(orderRequest.totalPrice))}đ',
                      textAlign: TextAlign.end,
                      style: textStyleH6.copyWith(
                        color: ColorResources.RED,
                      ),
                    )
                  : const SizedBox();
            }),
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_2X,
          ),
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              constraints: BoxConstraints(
                maxWidth: IZIDimensions.ONE_UNIT_SIZE * 250,
              ),
              alignment: Alignment.center,
              height: IZIDimensions.ONE_UNIT_SIZE * 80,
              color: ColorResources.PRIMARY_1,
              child: Text(
                "Thanh toán",
                style: textStyleH6.copyWith(
                  color: ColorResources.WHITE,
                ),
              ),
            ),
          ),
        ],
      ),
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
    );
  }

  ///
  ///  Sản phẩm
  ///
  Widget productSize({required String size, required int value, required int groupValue, required Function(int val) onChanged}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          size,
          style: textStyleH6.copyWith(
            color: ColorResources.NEUTRALS_4,
            fontWeight: FontWeight.w600,
          ),
        ),
        Radio<int>(
          value: value,
          groupValue: groupValue,
          onChanged: (val) {
            onChanged(val!);
          },
        ),
      ],
    );
  }
}
