import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/order/order_product/order_product.dart';
import 'package:template/data/model/order/order_request.dart';
import 'package:template/data/model/product/options/options_size.dart';
import 'package:template/data/model/product/options/options_topping.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import '../../../base_widget/izi_button.dart';
import '../../../base_widget/izi_image.dart';
import '../../../base_widget/izi_input.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../helper/izi_other.dart';
import '../../../helper/izi_text_style.dart';
import '../../../utils/color_resources.dart';

class ProductBottomSheet extends StatelessWidget {
  ProductBottomSheet({
    Key? key,
    required this.image,
    required this.name,
    required this.desription,
    required this.numberOfSale,
    required this.onTap,
    required this.optionsSize,
    required this.optionsTopping,
    required this.product,
  }) : super(key: key);
  final String image;
  final String name;
  final String desription;
  final String numberOfSale;
  final ProductResponse product;
  final Function(OrderRequest order) onTap;
  final List<OptionsSize> optionsSize;
  final List<OptionsTopping> optionsTopping;
  RxInt groupValue = 99.obs;
  RxInt amount = 1.obs;
  String noteDescription = '';
  RxList<OptionsTopping> toppings = <OptionsTopping>[].obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        IZIOther.primaryFocus();
      },
      child: SizedBox(
        height: IZIDimensions.iziSize.height * 0.7,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              IZIDimensions.BLUR_RADIUS_4X,
                            ),
                            topRight: Radius.circular(
                              IZIDimensions.BLUR_RADIUS_4X,
                            ),
                          ),
                          child: SizedBox(
                            height: IZIDimensions.ONE_UNIT_SIZE * 250,
                            width: IZIDimensions.iziSize.width,
                            child: IZIImage(image),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.SPACE_SIZE_4X,
                          ),
                          color: ColorResources.WHITE,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              Text(
                                name,
                                style: textStyleH4.copyWith(
                                  color: ColorResources.NEUTRALS_2,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              Text(
                                desription,
                                style: textStyleSpan,
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '${numberOfSale} ',
                                  style: textStyleSpan.copyWith(
                                    color: ColorResources.NEUTRALS_2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'sản phẩm đã bán',
                                      style: textStyleSpan,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              IZIInput(
                                type: IZIInputType.MILTIPLINE,
                                placeHolder: "Ghi chú thêm cho món (nếu có)",
                                fillColor: ColorResources.NEUTRALS_7,
                                maxLine: 3,
                                onChanged: (val) {
                                  noteDescription = val;
                                },
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              if (!IZIValidate.nullOrEmpty(optionsSize))
                                Text(
                                  "Size",
                                  style: textStyleH6.copyWith(
                                    color: ColorResources.NEUTRALS_2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              Column(
                                children: [
                                  ...List.generate(optionsSize.length, (index) {
                                    return Obx(() {
                                      return productSize(
                                        groupValue: groupValue.value,
                                        onChanged: (index) {
                                          groupValue.value = index;
                                        },
                                        size: 'Size ${optionsSize[index].size ?? ''}',
                                        value: index,
                                      );
                                    });
                                  })
                                ],
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              if (!IZIValidate.nullOrEmpty(optionsTopping))
                                Text(
                                  "Toppings",
                                  style: textStyleH6.copyWith(
                                    color: ColorResources.NEUTRALS_2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              Column(
                                children: [
                                  ...List.generate(
                                    optionsTopping.length,
                                    (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // print('Toppgin: ${optionsTopping[index].toJson()}');
                                          toppings.add(optionsTopping[index]);
                                        },
                                        child: Obx(() {
                                          return topping(
                                              amount: toppings.where((element) => optionsTopping[index].hashCode == element.hashCode).length,
                                              name: optionsTopping[index].topping ?? '',
                                              price: '${IZIPrice.currencyConverterVND(IZINumber.parseDouble(optionsTopping[index].price))}đ',
                                              onClear: () {
                                                toppings.removeWhere((element) => optionsTopping[index].hashCode == element.hashCode);
                                              });
                                        }),
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
                      ],
                    ),

                    // Cancle
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: ColorResources.RED,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Thêm sản phẩm

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: IZIDimensions.SPACE_SIZE_4X,
              ),
              color: ColorResources.WHITE,
              child: Row(
                children: [
                  Expanded(
                    child: IZIInput(
                      type: IZIInputType.INCREMENT,
                      padding: EdgeInsets.zero,
                      height: IZIDimensions.ONE_UNIT_SIZE * 50,
                      widthIncrement: IZIDimensions.ONE_UNIT_SIZE * 50,
                      width: IZIDimensions.ONE_UNIT_SIZE * 100,
                      fillColor: ColorResources.WHITE,
                      style: textStyleH6.copyWith(
                        color: ColorResources.NEUTRALS_2,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: (val) {
                        amount.value = IZINumber.parseInt(val.replaceAll(',', '').replaceAll('.', ''));
                      },
                      allowEdit: false,
                      colorBorder: ColorResources.NEUTRALS_2,
                      max: 99,
                      disbleError: true,
                    ),
                  ),
                  SizedBox(
                    width: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  Obx(() {
                    return IZIButton(
                      onTap: () {
                        onTap(order());
                      },
                      label: "Thêm +${IZIPrice.currencyConverterVND(priceTotalOrder())}đ",
                      borderRadius: IZIDimensions.BORDER_RADIUS_2X,
                      padding: EdgeInsets.symmetric(
                        vertical: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      width: IZIDimensions.ONE_UNIT_SIZE * 250,
                    );
                  }),
                ],
              ),
            ),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_4X,
            ),
          ],
        ),
      ),
    );
  }

  OrderRequest order() {
    final OrderRequest orderResponse = OrderRequest();
    final OrderProduct orderProduct = OrderProduct();

    orderProduct.amount = amount.value;
    orderProduct.optionsSize = IZIValidate.nullOrEmpty(optionsSize) || groupValue.value > optionsSize.length ? null : optionsSize[groupValue.value];
    orderProduct.optionsTopping = IZIValidate.nullOrEmpty(optionsTopping) ? null : toppings;
    orderProduct.description = noteDescription;
    orderProduct.idProduct = product;
    orderProduct.price = priceSingleOrder();
    orderResponse.idProducts = [orderProduct];
    orderResponse.totalPrice = priceTotalOrder();

    return orderResponse;
  }

  ///
  /// total price of product
  ///
  double priceTotalOrder() {
    if (IZIValidate.nullOrEmpty(optionsSize) || groupValue.value > optionsSize.length) {
      return (amount.value * IZINumber.parseDouble(product.price)) +
          toppings.fold<double>(
            0,
            (previousValue, element) {
              return previousValue += element.price!;
            },
          );
    }
    return (amount.value * optionsSize[groupValue.value].price!) +
        IZINumber.parseDouble(product.price) +
        toppings.fold<double>(
          0,
          (previousValue, element) {
            return previousValue += element.price!;
          },
        );
  }

  ///
  /// price of a product
  ///
  double priceSingleOrder() {
    if (IZIValidate.nullOrEmpty(optionsSize) || groupValue.value > optionsSize.length) {
      return IZINumber.parseDouble(product.price) +
          toppings.fold<double>(
            0,
            (previousValue, element) {
              return previousValue += element.price!;
            },
          );
    }
    return (optionsSize[groupValue.value].price!) +
        IZINumber.parseDouble(product.price) +
        toppings.fold<double>(
          0,
          (previousValue, element) {
            return previousValue += element.price!;
          },
        );
  }

  ///
  /// Toppings
  ///
  Widget topping({
    required int amount,
    required String name,
    required String price,
    required Function onClear,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_1X,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (amount > 0)
                Text(
                  "${amount}x",
                  style: textStyleSpan.copyWith(
                    color: ColorResources.NEUTRALS_4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (amount > 0)
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_1X,
                ),
              Text(
                name,
                style: textStyleSpan.copyWith(
                  color: ColorResources.NEUTRALS_4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                price,
                style: textStyleSpan.copyWith(
                  color: ColorResources.NEUTRALS_4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              if (amount > 0)
                GestureDetector(
                  onTap: () {
                    onClear();
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: ColorResources.RED,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///  Sản phẩm
  ///
  Widget productSize({
    required String size,
    required int value,
    required int groupValue,
    required Function(int val) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          size,
          style: textStyleSpan.copyWith(
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
