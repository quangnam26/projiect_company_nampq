import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/data/model/cart/cart_response.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/cart/cart_controller.dart';

import '../../../base_widget/izi_app_bar.dart';

class CartPage extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CartController(),
      builder: (CartController controller) {
        return IZIScreen(
          background: const BackgroundAppBar(),
          appBar: const IZIAppBar(
            title: 'Giỏ hàng',
          ),

          //  IZIAppBar(
          //   widthIconBack: IZIDimensions.iziSize.width,
          //   iconBack: Row(
          //     children: [
          //       IZIText(
          //         text: "Giỏ hàng",
          //         style: TextStyle(
          //           color: ColorResources.PRIMARY_2,
          //           fontWeight: FontWeight.w700,
          //           fontSize: IZIDimensions.FONT_SIZE_H6,
          //         ),
          //       )
          //     ],
          //   ),
          //   title: '',
          // ),
          body: ValueListenableBuilder<bool>(
            valueListenable: controller.loading,
            builder: (_, loading, __) {
              if (loading) {
                return SizedBox(
                  height: IZIDimensions.iziSize.height * 0.8,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return ValueListenableBuilder<CartResponse>(
                valueListenable: controller.cart,
                builder: (_, value, __) {
                  return value.itemsOption == null || value.itemsOption!.isEmpty
                      ? SizedBox(
                          height: IZIDimensions.iziSize.height * 0.7,
                          child: Center(
                            child: Text(
                              'Giỏ hàng rỗng',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: ColorResources.NEUTRALS_5,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: IZIDimensions.SPACE_SIZE_4X,
                                left: IZIDimensions.SPACE_SIZE_4X,
                                right: IZIDimensions.SPACE_SIZE_4X,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IZIText(
                                    text: value.itemsOption == null
                                        ? '0 sản phẩm'
                                        : "${value.itemsOption!.length} sản phẩm",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: ColorResources.PRIMARY_7,
                                      fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_5X * 3,
                              ),
                              child: IZIListView(
                                itemCount: value.itemsOption == null ? 0 : value.itemsOption!.length,
                                builder: (index) {
                                  return itemOptionWidget(
                                    context,
                                    controller,
                                    index,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                },
              );
            },
          ),
          bottomNavigator: ValueListenableBuilder<bool>(
            valueListenable: controller.loading,
            builder: (_, loading, __) {
              if (loading) {
                return const SizedBox();
              }
              return ValueListenableBuilder<CartResponse>(
                valueListenable: controller.cart,
                builder: (_, value, __) {
                  if (value.itemsOption == null || value.itemsOption!.isEmpty) {
                    return const SizedBox();
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_5X * 1.2),
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IZIText(
                              text: "Tổng thanh toán",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: IZIDimensions.FONT_SIZE_SPAN * 1.1,
                                color: ColorResources.PRIMARY_9,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IZIText(
                              text: "${IZIPrice.currencyConverterVND(controller.toTalPrice())} đ",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: IZIDimensions.FONT_SIZE_H6 * 1.1,
                                color: ColorResources.PRICE,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IZIButton(
                        padding: EdgeInsets.symmetric(
                          vertical: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_4X * 1.2,
                        ),
                        onTap: () {
                          controller.onGoToPayMent();
                        },
                        label: "Thanh toán",
                        colorBG: ColorResources.ORANGE,
                        fontSizedLabel: IZIDimensions.FONT_SIZE_SPAN,
                      ),
                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 40,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  ///
  ///itemOptionWidget
  ///
  Container itemOptionWidget(BuildContext context, CartController controller, int index) {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
      ),
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_1X,
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        border: Border.all(
          color: ColorResources.NEUTRALS_5.withOpacity(0.3),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          checkboxWidget(
            controller,
            index,
          ),
          imageItemWidget(controller, index),
          infoProduct(
            context,
            controller,
            index,
          ),
        ],
      ),
    );
  }

  ///
  ///infoProduct
  ///
  Expanded infoProduct(BuildContext context, CartController controller, int index) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_2X),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
                    child: IZIText(
                      text: controller.cart.value.itemsOption![index].idProduct!.name ?? '',
                      maxLine: 2,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: ColorResources.PRIMARY_9,
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.deleteItemDialog(context,
                        productId: controller.cart.value.itemsOption![index].id.toString());
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
                    child: IZIImage(ImagesPath.trash),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: IZIText(
                    text:
                        '${IZIPrice.currencyConverterVND(controller.showPriceFollowQuantity(controller.cart.value.itemsOption![index]))}đ',
                    maxLine: 2,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: ColorResources.PRICE,
                      fontSize: IZIDimensions.FONT_SIZE_SPAN * 1.1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: IZIDimensions.ONE_UNIT_SIZE * 180,
                    ),
                    child: IZIInput(
                      key: Key(controller.cart.value.itemsOption![index].hashCode.toString()),
                      controller: controller.cart.value.itemsOption![index].controller,
                      type: IZIInputType.INCREMENT,
                      width: IZIDimensions.ONE_UNIT_SIZE * 100,
                      borderRadius: 5,
                      initValue:
                          controller.showQuantityProductAddedCart(controller.cart.value.itemsOption![index]).toString(),
                      onChanged: (val) {
                        controller.addProductToCart(
                            productId: controller.cart.value.itemsOption![index].id.toString(), amount: val);
                      },
                      max: controller.getMaxProduct(controller.cart.value.itemsOption![index]),
                      allowEdit: false,
                      widthIncrement: IZIDimensions.ONE_UNIT_SIZE * 40,
                      height: IZIDimensions.ONE_UNIT_SIZE * 40,
                      // fillColor: ColorResources.NEUTRALS_7,
                      fillColor: ColorResources.WHITE,
                      colorBorder: ColorResources.PRIMARY_3,
                      style: const TextStyle(
                        color: ColorResources.NEUTRALS_2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
  ///imageItemWidget
  ///
  ClipRRect imageItemWidget(CartController controller, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: IZIImage(
        controller.cart.value.itemsOption![index].idProduct!.thumbnail ?? '',
        width: IZIDimensions.ONE_UNIT_SIZE * 100,
        height: IZIDimensions.ONE_UNIT_SIZE * 100,
      ),
    );
  }

  ///
  ///checkboxWidget
  ///
  Checkbox checkboxWidget(CartController controller, int index) {
    return Checkbox(
      value: controller.cart.value.itemsOption![index].isSelected,
      onChanged: (v) {
        controller.selectedProduct(controller.cart.value.itemsOption![index]);
      },
      side: const BorderSide(width: 1.4),
    );
  }
}
